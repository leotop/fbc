'' intrinsic runtime lib printing functions (PRINT, WRITE, LPRINT, USING, ...)
''
'' chng: oct/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "lex.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' sub fb_PrintVoid( byval fnum as long = 0, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTVOID, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintByte( byval fnum as long = 0, byval x as byte, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_BYTE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintUByte( byval fnum as long = 0, byval x as ubyte, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTUBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintShort( byval fnum as long = 0, byval x as short, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintUShort( byval fnum as long = 0, byval x as ushort, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTUSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintInt( byval fnum as long = 0, byval x as long, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintUInt( byval fnum as long = 0, byval x as ulong, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTUINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintLongint( byval fnum as integer = 0, byval x as longint, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTLONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintULongint( byval fnum as long = 0, byval x as ulongint, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTULONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintSingle( byval fnum as long = 0, byval x as single, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTSINGLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintDouble( byval fnum as long = 0, byval x as double, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTDOUBLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintString( byval fnum as long = 0, byref x as string, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTSTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintWstr( byval fnum as long = 0, byval x as wstring ptr, byval mask as long ) '/ _
		( _
			@FB_RTL_PRINTWSTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintVoid( byval fnum as long = 0, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTVOID, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintByte( byval fnum as long = 0, byval x as byte, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_BYTE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintUByte( byval fnum as long = 0, byval x as ubyte, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTUBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintShort( byval fnum as long = 0, byval x as short, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintUShort( byval fnum as long = 0, byval x as ushort, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTUSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintInt( byval fnum as long = 0, byval x as long, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintUInt( byval fnum as long = 0, byval x as ulong, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTUINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintLongint( byval fnum as long = 0, byval x as longint, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTLONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintULongint( byval fnum as long = 0, byval x as ulongint, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTULONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintSingle( byval fnum as long = 0, byval x as single, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTSINGLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintDouble( byval fnum as long = 0, byval x as double, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTDOUBLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintString( byval fnum as long = 0, byref x as string, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTSTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_LPrintWstr( byval fnum as long = 0, byval x as wstring ptr, byval mask as long ) '/ _
		( _
			@FB_RTL_LPRINTWSTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintSPC( byval fnum as long = 0, byval n as integer ) '/ _
		( _
			@FB_RTL_PRINTSPC, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_PrintTab( byval fnum as long = 0, byval newcol as long ) '/ _
		( _
			@FB_RTL_PRINTTAB, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteVoid( byval fnum as long = 0, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITEVOID, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteByte( byval fnum as long = 0, byval x as byte, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITEBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_BYTE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteUByte( byval fnum as long = 0, byval x as ubyte, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITEUBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteShort( byval fnum as long = 0, byval x as short, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITESHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteUShort( byval fnum as long = 0, byval x as ushort, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITEUSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteInt( byval fnum as long = 0, byval x as long, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITEINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteUInt( byval fnum as long = 0, byval x as ulong, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITEUINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteLongint( byval fnum as long = 0, byval x as longint, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITELONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteULongint( byval fnum as long = 0, byval x as ulongint, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITEULONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteSingle( byval fnum as long = 0, byval x as single, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITESINGLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteDouble( byval fnum as long = 0, byval x as double, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITEDOUBLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteString( byval fnum as long = 0, byref x as string, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITESTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_WriteWstr( byval fnum as long = 0, byval x as wstring ptr, byval mask as long ) '/ _
		( _
			@FB_RTL_WRITEWSTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_PrintUsingInit( byref fmtstr as string ) as long '/ _
		( _
			@FB_RTL_PRINTUSGINIT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_PrintUsingStr( byval fnum as long, byref s as string, byval mask as long ) as long '/ _
		( _
			@FB_RTL_PRINTUSGSTR, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_PrintUsingWstr( byval fnum as long, byval s as wstring ptr, byval mask as long ) as long '/ _
		( _
			@FB_RTL_PRINTUSGWSTR, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_PrintUsingSingle( byval fnum as long, byval v as single, byval mask as long ) as long '/ _
		( _
			@FB_RTL_PRINTUSG_SNG, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_PrintUsingDouble( byval fnum as long, byval v as double, byval mask as long ) as long '/ _
		( _
			@FB_RTL_PRINTUSG_DBL, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_PrintUsingLongint( byval fnum as long, byval v as longint, byval mask as long ) as long '/ _
		( _
			@FB_RTL_PRINTUSG_LL, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_PrintUsingULongint( byval fnum as long, byval v as ulongint, byval mask as long ) as long '/ _
		( _
			@FB_RTL_PRINTUSG_ULL, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_PrintUsingEnd( byval fnum as long ) as long '/ _
		( _
			@FB_RTL_PRINTUSGEND, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_LPrintUsingInit( byref fmtstr as string ) as long '/ _
		( _
			@FB_RTL_LPRINTUSGINIT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }

'':::::
sub rtlPrintModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlPrintModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlPrint _
	( _
		byval fileexpr as ASTNODE ptr, _
		byval iscomma as integer, _
		byval issemicolon as integer, _
		byval expr as ASTNODE ptr, _
        byval islprint as integer = FALSE _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer mask = any

    function = FALSE

	if( expr = NULL ) then
		if( islprint ) then
			f = PROCLOOKUP( LPRINTVOID )
		else
			f = PROCLOOKUP( PRINTVOID )
		end if
	else
		'' UDT? try to convert to string with type casting op overloading
		select case typeGet( astGetDataType( expr ) )
		case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
			expr = astNewOvlCONV( FB_DATATYPE_STRING, NULL, expr )
			if( expr = NULL ) then
				exit function
			end if
		end select

		'' Convert pointer to uinteger
		if( typeIsPtr( astGetFullType( expr ) ) ) then
			expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )
		end if

		select case as const typeGet( astGetDataType( expr ) )
		case FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, FB_DATATYPE_CHAR
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSTR )
			else
				f = PROCLOOKUP( PRINTSTR )
			end if

		case FB_DATATYPE_WCHAR
			if( islprint ) then
				f = PROCLOOKUP( LPRINTWSTR )
			else
				f = PROCLOOKUP( PRINTWSTR )
			end if

		case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE, _
		     FB_DATATYPE_SHORT, FB_DATATYPE_USHORT, _
		     FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM, FB_DATATYPE_UINT, _
		     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
		     FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT

			select case as const( typeGetSizeType( astGetFullType( expr ) ) )
			case FB_SIZETYPE_INT8
				if( islprint ) then
					f = PROCLOOKUP( LPRINTBYTE )
				else
					f = PROCLOOKUP( PRINTBYTE )
				end if

			case FB_SIZETYPE_UINT8
				if( islprint ) then
					f = PROCLOOKUP( LPRINTUBYTE )
				else
					f = PROCLOOKUP( PRINTUBYTE )
				end if

			case FB_SIZETYPE_INT16
				if( islprint ) then
					f = PROCLOOKUP( LPRINTSHORT )
				else
					f = PROCLOOKUP( PRINTSHORT )
				end if

			case FB_SIZETYPE_UINT16
				if( islprint ) then
					f = PROCLOOKUP( LPRINTUSHORT )
				else
					f = PROCLOOKUP( PRINTUSHORT )
				end if

			case FB_SIZETYPE_INT32
				if( islprint ) then
					f = PROCLOOKUP( LPRINTINT )
				else
					f = PROCLOOKUP( PRINTINT )
				end if

			case FB_SIZETYPE_UINT32
				if( islprint ) then
					f = PROCLOOKUP( LPRINTUINT )
				else
					f = PROCLOOKUP( PRINTUINT )
				end if

			case FB_SIZETYPE_INT64
				if( islprint ) then
					f = PROCLOOKUP( LPRINTLONGINT )
				else
					f = PROCLOOKUP( PRINTLONGINT )
				end if

			case FB_SIZETYPE_UINT64
				if( islprint ) then
					f = PROCLOOKUP( LPRINTULONGINT )
				else
					f = PROCLOOKUP( PRINTULONGINT )
				end if
			end select

		case FB_DATATYPE_SINGLE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSINGLE )
			else
				f = PROCLOOKUP( PRINTSINGLE )
			end if

		case FB_DATATYPE_DOUBLE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTDOUBLE )
			else
				f = PROCLOOKUP( PRINTDOUBLE )
			end if

		case else
			exit function
		end select
	end if

    ''
	proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    if( expr <> NULL ) then
    	'' byval? x as ???
    	if( astNewARG( proc, expr ) = NULL ) then
 			exit function
 		end if
    end if

	'' byval mask as integer
	mask = 0
	if( fbLangIsSet( FB_LANG_QB ) ) then mask or= FB_PRINTMASK_APPEND_SPACE
	if( iscomma ) then
		mask or= FB_PRINTMASK_PAD
	elseif( issemicolon = FALSE ) then
		mask or= FB_PRINTMASK_NEWLINE
	end if

	if( astNewARG( proc, astNewCONSTi( mask ) ) = NULL ) then
		exit function
	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintSPCTab _
	( _
		byval fileexpr as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
		byval istab as integer, _
		byval islprint as integer = FALSE _
	) as integer

    dim as ASTNODE ptr proc = any

	function = FALSE

    if islprint then
    	rtlPrinter_cb( NULL )
    end if

	''
	if( istab ) then
		proc = astNewCALL( PROCLOOKUP( PRINTSPC ) )
	else
		proc = astNewCALL( PROCLOOKUP( PRINTTAB ) )
	end if

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' byval n as integer
    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlWrite _
	( _
		byval fileexpr as ASTNODE ptr, _
		byval iscomma as integer, _
		byval expr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer mask = any

	function = FALSE

	if( expr = NULL ) then
		f = PROCLOOKUP( WRITEVOID )
	else
		'' UDT? try to convert to string with type casting op overloading
		select case astGetDataType( expr )
		case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
			expr = astNewOvlCONV( FB_DATATYPE_STRING, NULL, expr )
			if( expr = NULL ) then
				exit function
			end if
		end select

		'' Convert pointer to uinteger
		if( typeIsPtr( astGetFullType( expr ) ) ) then
			expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )
		end if

		select case as const typeGet( astGetDataType( expr ) )
		case FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, FB_DATATYPE_CHAR
			f = PROCLOOKUP( WRITESTR )

		case FB_DATATYPE_WCHAR
			f = PROCLOOKUP( WRITEWSTR )

		case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE, _
		     FB_DATATYPE_SHORT, FB_DATATYPE_USHORT, _
		     FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM, FB_DATATYPE_UINT, _
		     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
		     FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT

			select case as const( typeGetSizeType( astGetFullType( expr ) ) )
			case FB_SIZETYPE_INT8   : f = PROCLOOKUP( WRITEBYTE )
			case FB_SIZETYPE_UINT8  : f = PROCLOOKUP( WRITEUBYTE )
			case FB_SIZETYPE_INT16  : f = PROCLOOKUP( WRITESHORT )
			case FB_SIZETYPE_UINT16 : f = PROCLOOKUP( WRITEUSHORT )
			case FB_SIZETYPE_INT32  : f = PROCLOOKUP( WRITEINT )
			case FB_SIZETYPE_UINT32 : f = PROCLOOKUP( WRITEUINT )
			case FB_SIZETYPE_INT64  : f = PROCLOOKUP( WRITELONGINT )
			case FB_SIZETYPE_UINT64 : f = PROCLOOKUP( WRITEULONGINT )
			end select

		case FB_DATATYPE_SINGLE
			f = PROCLOOKUP( WRITESINGLE )

		case FB_DATATYPE_DOUBLE
			f = PROCLOOKUP( WRITEDOUBLE )

		case else
			exit function
		end select
	end if

    ''
	proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    if( expr <> NULL ) then
    	'' byval? x as ???
    	if( astNewARG( proc, expr ) = NULL ) then
 			exit function
 		end if
    end if

    '' byval mask as integer
	mask = 0
	if( iscomma ) then
		mask or= FB_PRINTMASK_PAD
	else
		mask or= FB_PRINTMASK_NEWLINE
	end if

	if( astNewARG( proc, astNewCONSTi( mask ) ) = NULL ) then
		exit function
	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsingInit _
	( _
		byval usingexpr as ASTNODE ptr, _
        byval islprint as integer = FALSE _
	) as integer 

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any

	function = FALSE

	''
	if( islprint ) then
		f = PROCLOOKUP( LPRINTUSGINIT )
	else
		f = PROCLOOKUP( PRINTUSGINIT )
	end if
    proc = astNewCALL( f )

    '' fmtstr as string
    if( astNewARG( proc, usingexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsingEnd _
	( _
		byval fileexpr as ASTNODE ptr, _
        byval islprint as integer = FALSE _
	) as integer

    dim as ASTNODE ptr proc = any

	function = FALSE

    if islprint then
    	rtlPrinter_cb( NULL )
    end if

	''
    proc = astNewCALL( PROCLOOKUP( PRINTUSGEND ) )

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsing _
	( _
		byval fileexpr as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
		byval iscomma as integer, _
		byval issemicolon as integer, _
        byval islprint as integer = FALSE _
    ) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer mask = any

	function = FALSE

    if( islprint ) then
    	rtlPrinter_cb( NULL )
    end if

    if( expr = NULL ) then
    	exit function
    end if

	'' UDT? try to convert to double with type casting op overloading
	select case astGetDataType( expr )
	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
		expr = astNewOvlCONV( FB_DATATYPE_DOUBLE, NULL, expr )
		if( expr = NULL ) then
			exit function
		end if
	end select

	select case astGetDataType( expr )
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, FB_DATATYPE_CHAR
		f = PROCLOOKUP( PRINTUSGSTR )

	case FB_DATATYPE_WCHAR
		f = PROCLOOKUP( PRINTUSGWSTR )

	case FB_DATATYPE_SINGLE
		f = PROCLOOKUP( PRINTUSG_SNG )

	case FB_DATATYPE_LONGINT, _
	    FB_DATATYPE_INTEGER, _
	    FB_DATATYPE_LONG, _
	    FB_DATATYPE_SHORT, _
	    FB_DATATYPE_BYTE

		f = PROCLOOKUP( PRINTUSG_LL )

	case FB_DATATYPE_ULONGINT, _
	    FB_DATATYPE_UINT, _
	    FB_DATATYPE_ULONG, _
	    FB_DATATYPE_USHORT, _
	    FB_DATATYPE_UBYTE

		f = PROCLOOKUP( PRINTUSG_ULL )

	case else
		f = PROCLOOKUP( PRINTUSG_DBL )
	end select

	proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' s as string or byval v as double
    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

    '' byval mask as integer
	if( iscomma or issemicolon ) then
		mask = 0

#if 0
		'' this allows commas to print padding like in regular PRINTs
		'' (QB doesn't support this though - the IDE just converts them to semicolons)
		if( iscomma ) then
			mask or= FB_PRINTMASK_PAD
		end if
#endif

	else
		mask = FB_PRINTMASK_NEWLINE or FB_PRINTMASK_ISLAST
	end if

	if( astNewARG( proc, astNewCONSTi( mask ) ) = NULL ) then
		exit function
	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlWidthDev _
	( _
		byval device as ASTNODE ptr, _
		byval width_arg as ASTNODE ptr, _
        byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

    '' printer libraries are always required for width on devices
	rtlPrinter_cb( NULL )

	''
    proc = astNewCALL( PROCLOOKUP( WIDTHDEV ) )

    '' device as string
    if( astNewARG( proc, device ) = NULL ) then
    	exit function
    end if

    '' byval width_arg as integer
    if( astNewARG( proc, width_arg ) = NULL ) then
    	exit function
    end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function

'':::::
function rtlPrinter_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

    static as integer libsAdded = FALSE

	if( libsadded = FALSE ) then

        libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			fbAddLib("winspool")
			fbAddLib("gdi32")
		end select

	end if

    function = TRUE

end function
