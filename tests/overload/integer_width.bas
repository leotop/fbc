# include "fbcu.bi"

namespace fbc_tests.overloads.integer_width

	function hexa overload ( byval l as any ptr ) as integer
		function = 1
	end function

	function hexa( byval l as longint ) as integer
		function = 2
	end function

	sub zee_test cdecl( )
#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( hexa(0ull), 1 )
#else
		CU_ASSERT_EQUAL( hexa(0ull), 2 )
#endif
		CU_ASSERT_EQUAL( hexa(1ull shl 32), 2 )
	end sub

	private sub ctor () constructor
		fbcu.add_suite("fb-tests.overload.integer_width")
		fbcu.add_test("test", @zee_test)
	end sub

end namespace
