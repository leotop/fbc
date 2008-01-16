''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' main module, FreeBSD front-end
''
'' chng: jul/2007 written [DrV]


#include once "inc/fb.bi"
#include once "inc/fbc.bi"
#include once "inc/hlp.bi"


''
'' globals
''
	dim shared xpmfile as string

'':::::
private sub _setDefaultLibPaths

	fbcAddDefLibPath( "/usr/local/lib" )
	fbcAddDefLibPath( "/lib" )
	fbcAddDefLibPath( "/usr/lib" )

end sub

'':::::
private function _linkFiles _
	( _
	) as integer

	dim as string ldpath, ldcline, dllname

	function = FALSE

	'' set path
	ldpath = fbFindBinFile( "ld" )
	if( len( ldpath ) = 0 ) then
		exit function
	end if

	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		dllname = hStripPath( hStripExt( fbc.outname ) )
	end if

	'' add extension
	if( fbc.outaddext ) then
		select case fbGetOption( FB_COMPOPT_OUTTYPE )
		case FB_OUTTYPE_DYNAMICLIB
			fbc.outname = hStripFilename( fbc.outname ) + "lib" + hStripPath( fbc.outname ) + ".so"
		end select
	end if
	
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_EXECUTABLE) then
		ldcline = "-dynamic-linker /libexec/ld-elf.so.1"
	end if

	''
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		ldcline = "-shared --export-dynamic -h" + hStripPath( fbc.outname )

	else
		'' tell LD to add all symbols declared as EXPORT to the symbol table
		if( fbGetOption( FB_COMPOPT_EXPORT ) ) then
			ldcline += " --export-dynamic"
		end if
	end if

	'' set script file
	ldcline += (" -T " + QUOTE) + fbGetPath( FB_PATH_BIN ) + ("elf_i386.x" + QUOTE)

	if( len( fbc.mapfile ) > 0 ) then
		ldcline += " -Map " + fbc.mapfile
	end if

	''
	if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) = FALSE ) then
			ldcline += " -s"
		end if
	end if

	'' add library search paths
	ldcline += *fbcGetLibPathList( )

	dim as string libdir = fbGetPath( FB_PATH_LIB )

	'' crt init stuff
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_EXECUTABLE) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			ldcline += " " + QUOTE + libdir + ("/gcrt1.o" + QUOTE)
		else
			ldcline += " " + QUOTE + libdir + ("/crt1.o" + QUOTE)
		end if
	end if

	ldcline += " " + QUOTE + libdir + ("/crti.o" + QUOTE)
	ldcline += " " + QUOTE + libdir + ("/crtbegin.o" + QUOTE + " ")

	'' add objects from output list
	dim as FBC_IOFILE ptr iof = listGetHead( @fbc.inoutlist )
	do while( iof <> NULL )
		ldcline += QUOTE + iof->outf + (QUOTE + " ")
		iof = listGetNext( iof )
	loop

	'' add objects from cmm-line
	dim as string ptr objf = listGetHead( @fbc.objlist )
	do while( objf <> NULL )
		ldcline += QUOTE + *objf + (QUOTE + " ")
		objf = listGetNext( objf )
	loop

	'' set executable name
	ldcline += "-o " + QUOTE + fbc.outname + QUOTE

	'' init lib group
	ldcline += " -( "

	'' add libraries from cmm-line and found when parsing
	ldcline += *fbcGetLibList( dllname )

	if( fbGetOption( FB_COMPOPT_NODEFLIBS ) = FALSE ) then
		'' rtlib initialization and termination (must be included in the group or
		'' dlopen() will fail because fb_hRtExit() will be undefined)
		ldcline += QUOTE + libdir + ("/fbrt0.o" + QUOTE + " ")
	end if

	'' end lib group
	ldcline += "-) "

	'' crt end stuff
	ldcline += QUOTE + libdir + ("/crtend.o" + QUOTE + " " )
	ldcline += QUOTE + libdir + ("/crtn.o" + QUOTE)

   	'' extra options
   	ldcline += fbc.extopt.ld

	'' invoke ld
	if( fbc.verbose ) then
		print "linking: ", ldcline
	end if

	if( exec( ldpath, ldcline ) <> 0 ) then
		exit function
	end if

	function = TRUE

end function

'':::::
private function _archiveFiles( byval cmdline as zstring ptr ) as integer
	dim arcpath as string

	arcpath = fbFindBinFile( "ar" )
	if( len( arcpath ) = 0 ) then
		return FALSE
	end if

	if( exec( arcpath, *cmdline ) <> 0 ) then
		return FALSE
	end if

	return TRUE

end function

#define STATE_OUT_STRING	0
#define STATE_IN_STRING		1
#define CHAR_TAB			9
#define CHAR_QUOTE			34

'':::::
private function _compileResFiles _
	( _
	) as integer

	dim as integer fi, fo
	dim as integer outstr_count, buffer_len, state, label
	dim as ubyte ptr p
	dim as string * 4096 chunk
	dim as string aspath, iconsrc, buffer, outstr()

	function = FALSE

	if( fbGetOption( FB_COMPOPT_OUTTYPE ) <> FB_OUTTYPE_EXECUTABLE ) then
		return TRUE
	end if

	if( len( xpmfile ) = 0 ) then

		'' no icon supplied, provide a NULL symbol
		iconsrc = "$$fb_icon$$.asm"
		fo = freefile()
		open iconsrc for output as #fo
		print #fo, ".data"
		print #fo, ".align 32"
		print #fo, ".globl fb_program_icon"
		print #fo, "fb_program_icon:"
		print #fo, ".long 0"
		close #fo

	else
		'' invoke
		if( fbc.verbose ) then
			print "compiling XPM icon resource: ", xpmfile
		end if

		''
		if( hFileExists( xpmfile ) = FALSE ) then
			exit function
		end if
		iconsrc = hStripExt( hStripPath( xpmfile ) ) + ".asm"

		''
		fi = freefile()
		open xpmfile for input as #fi
		line input #1, buffer
		if( ucase( buffer ) <> "/* XPM */" ) then
			close #fi
			exit function
		end if
		buffer = ""
		while eof( fi ) = FALSE
			buffer_len = seek( fi )
			get #1,, chunk
			buffer_len = seek( fi ) - buffer_len
			buffer += left( chunk, buffer_len )
		wend
		close #fi
		buffer_len = len( buffer )
		p = sadd( buffer )

		''
		do
			select case state

			case STATE_OUT_STRING
				if( *p = CHAR_QUOTE ) then
					state = STATE_IN_STRING
					outstr_count += 1
					redim preserve outstr(outstr_count) as string
					outstr(outstr_count-1) = ""
				end if

			case STATE_IN_STRING
				if( *p = CHAR_QUOTE ) then
					state = STATE_OUT_STRING
				elseif( *p = CHAR_TAB ) then
					outstr(outstr_count-1) += RSLASH + "t"
				else
					outstr(outstr_count-1) += chr(*p)
				end if

			end select
			p += 1
			buffer_len -= 1
		loop while buffer_len > 0
		if( state <> STATE_OUT_STRING ) then
			exit function
		end if

		''
		fo = freefile()
		open iconsrc for output as #fo
		print #fo, ".section .rodata"
		for label = 0 to outstr_count-1
			print #fo, "_l" + hex( label ) + ":"
			print #fo, ".string " + QUOTE + outstr( label ) + QUOTE
		next label
		print #fo, ".section .data"
		print #fo, ".align 32"
		print #fo, "_xpm_data:"
		for label = 0 to outstr_count-1
			print #fo, ".long _l" + hex( label )
		next label
		print #fo, ".align 32"
		print #fo, ".globl fb_program_icon"
		print #fo, "fb_program_icon:"
		print #fo, ".long _xpm_data"
		close #fo
	end if

	'' compile icon source file
	aspath = fbFindBinFile( "as" )
	if( len( aspath ) = 0 ) then
		exit function
	end if

	if( exec( aspath, iconsrc + " -o " + hStripExt( iconsrc ) + ".o" ) ) then
		kill( iconsrc )
		exit function
	end if

	kill( iconsrc )

	'' add to obj list
	dim as string ptr objf = listNewNode( @fbc.objlist )
	*objf = hStripExt( iconsrc ) + ".o"

	function = TRUE

end function

'':::::
private function _delFiles as integer

	'' delete compiled icon object
	if( len( xpmfile ) = 0 ) then
		safeKill( "$$fb_icon$$.o" )
	else
		safeKill( hStripExt( hStripPath( xpmfile ) ) + ".o" )
	end if

	function = TRUE

end function

'':::::
private function _listFiles( byval argv as zstring ptr ) as integer

	if( hGetFileExt( argv ) = "xpm" ) then
		if( len( xpmfile ) <> 0 ) then
			return FALSE
		end if

		xpmfile = *argv
		return TRUE

	else
		return FALSE
	end if

end function

'':::::
private function _processOptions _
	( _
		byval opt as string ptr, _
		byval argv as string ptr _
	) as integer

	function = FALSE

end function

'':::::
function fbcInit_freebsd( ) as integer

    static as FBC_VTBL vtbl = _
    ( _
		@_processOptions, _
		@_listFiles, _
		@_compileResFiles, _
		@_linkFiles, _
		@_archiveFiles, _
		@_delFiles, _
		@_setDefaultLibPaths _
	)

	fbc.vtbl = vtbl

	''
	xpmfile = ""

	return TRUE

end function
