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
package Verhoeff
   with SPARK_Mode => On
is
   subtype Digit_Character is Character range '0' .. '9';
   
   function Check_Digit(Seq : in String) return Digit_Character
     with Pre => (for all I in Seq'Range => (Seq(I) in Digit_Character));
   -- Compute the verhoeff check digit on a sequence.
   --
   -- The Seq string must contain only digits ('0' .. '9').
   -- The string cannot contain any non-digit characters.
   
   function Is_Valid(Seq : in String) return Boolean
     with Pre => (Seq'Length > 0
                  and (for all I in Seq'Range => (Seq(I) in Digit_Character)));
   -- Validate the check digit on a sequence
   --
   -- The check digit must be the last digit in the sequence.
   --
   -- The Seq string must contain only digits ('0' .. '9').
   -- The string cannot contain any non-digit characters.

end Verhoeff;
