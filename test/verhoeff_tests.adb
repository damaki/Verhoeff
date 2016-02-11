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
with AUnit.Assertions; use AUnit.Assertions;
with Verhoeff;         use Verhoeff;

package body Verhoeff_Tests
is

   ----------------------------------------------------------------------------
   -- Test the example from Wikipedia: https://en.wikipedia.org/wiki/Verhoeff_algorithm
   -- (accessed 10th February 2016 at 13:23:00)
   -- 
   -- Checks that the string 236 has the check digit 3, and that Is_Valid
   -- accepts the check digit.
   procedure Test_Case_1(T : in out Test)
   is
      Test_String : constant String := "236";
      
      Computed_Check_Digit : Digit_Character;

   begin
      Computed_Check_Digit := Check_Digit(Test_String);
      
      Assert(Computed_Check_Digit = '3',
             "wrong check digit returned: " & Computed_Check_Digit);
             
      Assert(Is_Valid(Test_String & Computed_Check_Digit),
             "Is_Valid failed");

   end Test_Case_1;
   
   ----------------------------------------------------------------------------
   -- Test the example http://www.augustana.ab.ca/~mohrj/algorithms/checkdigit.html
   -- (accessed 10th February 2016 at 13:23:00)
   -- 
   -- Checks that the string 12345 has the check digit 1, and that Is_Valid
   -- accepts the check digit.
   procedure Test_Case_2(T : in out Test)
   is
      Test_String : constant String := "12345";
      
      Computed_Check_Digit : Digit_Character;

   begin
      Computed_Check_Digit := Check_Digit(Test_String);
      
      Assert(Computed_Check_Digit = '1',
             "wrong check digit returned: " & Computed_Check_Digit);
             
      Assert(Is_Valid(Test_String & Computed_Check_Digit),
             "Is_Valid failed");

   end Test_Case_2;
   
   ----------------------------------------------------------------------------
   -- Test that for every possible 6-digit string
   -- the resulting check digit is accepted as valid by Is_Valid, and that
   -- Is_Valid rejects any other (invalid) check digits.
   --
   -- This test basically checks the library against itself; that it accepts
   -- the check digits it computes and rejects any others.
   procedure Test_Symmetry(T : in out Test)
   is
      Test_String          : String(1 .. 6);
      Computed_Check_Digit : Digit_Character;
      
   begin
      for A in Digit_Character loop
         for B in Digit_Character loop
            for C in Digit_Character loop
               for D in Digit_Character loop
                  for E in Digit_Character loop
                     for F in Digit_Character loop
                        Test_String := String'(A,B,C,D,E,F);
                     
                        Computed_Check_Digit := Check_Digit(Test_String);
                     
                        -- Check that the check digit is valid
                        Assert(Is_Valid(Test_String & Computed_Check_Digit),
                               "computed check digit is invalid:" & 
                                Test_String & ' ' & Character(Computed_Check_Digit));
                            
                        -- Check that all other check digits are invalid
                        Assert((for all Invalid_Check_Digit in Digit_Character'Range =>
                                  (if Invalid_Check_Digit /= Computed_Check_Digit
                                   then not Is_Valid(Test_String & Invalid_Check_Digit)
                                  )
                               ),
                               "Is_Valid does not reject invalid check digits for: " & Test_String);
                     end loop;
                  end loop;
               end loop;
            end loop;
         end loop;
      end loop;
   
   end Test_Symmetry;
   
   ----------------------------------------------------------------------------
   -- Test the check digit of the empty string.
   --
   -- The check digit of an empty string should be 0.
   procedure Test_Empty(T : in out Test)
   is
   begin
      Assert(Check_Digit("") = '0',
             "check digit of an empty string is not 0");
      Assert(Is_Valid("0"),
             "Is_Valid failed");
   end Test_Empty;

end Verhoeff_Tests;
