-------------------------------------------------------------------------------
-- Copyright (c) 2016 Daniel King
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to
-- deal in the Software without restriction, including without limitation the
-- rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
-- sell copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
-- IN THE SOFTWARE.
-------------------------------------------------------------------------------
with AUnit.Test_Caller;
with Verhoeff_Tests;

package body Verhoeff_Suite
is
   package Caller is new AUnit.Test_Caller(Verhoeff_Tests.Test);

   function Suite return Access_Test_Suite
   is
      Ret : Access_Test_Suite := new AUnit.Test_Suites.Test_Suite;

   begin
      Ret.Add_Test(Caller.Create("Test case 1: 236",
                   Verhoeff_Tests.Test_Case_1'Access));
      Ret.Add_Test(Caller.Create("Test case 2: 12345",
                   Verhoeff_Tests.Test_Case_2'Access));
      Ret.Add_Test(Caller.Create("Test symmetry",
                   Verhoeff_Tests.Test_Symmetry'Access));
      Ret.Add_Test(Caller.Create("Test empty string",
                   Verhoeff_Tests.Test_Empty'Access));

      return Ret;
   end Suite;

end Verhoeff_Suite;
