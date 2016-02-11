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
package body Verhoeff
   with SPARK_Mode => On
is
   type Digit_Number is new Natural range 0 .. 9;

   D : constant array(Digit_Number, Digit_Number) of Digit_Number :=
    ((0, 1, 2, 3, 4, 5, 6, 7, 8, 9),
     (1, 2, 3, 4, 0, 6, 7, 8, 9, 5),
     (2, 3, 4, 0, 1, 7, 8, 9, 5, 6),
     (3, 4, 0, 1, 2, 8, 9, 5, 6, 7),
     (4, 0, 1, 2, 3, 9, 5, 6, 7, 8),
     (5, 9, 8, 7, 6, 0, 4, 3, 2, 1),
     (6, 5, 9, 8, 7, 1, 0, 4, 3, 2),
     (7, 6, 5, 9, 8, 2, 1, 0, 4, 3),
     (8, 7, 6, 5, 9, 3, 2, 1, 0, 4),
     (9, 8, 7, 6, 5, 4, 3, 2, 1, 0));
   
   Inv : constant array(Digit_Number) of Digit_Number :=
    (0, 4, 3, 2, 1, 5, 6, 7, 8, 9);
    
   P : constant array(Digit_Number range 0 .. 7, Digit_Number) of Digit_Number :=
    ((0, 1, 2, 3, 4, 5, 6, 7, 8, 9),
     (1, 5, 7, 6, 2, 8, 3, 0, 9, 4),
     (5, 8, 0, 3, 7, 9, 6, 1, 4, 2),
     (8, 9, 1, 6, 0, 4, 3, 5, 2, 7),
     (9, 4, 5, 3, 1, 2, 6, 8, 7, 0),
     (4, 2, 8, 6, 5, 7, 3, 9, 0, 1),
     (2, 7, 9, 3, 8, 0, 6, 4, 1, 5),
     (7, 0, 4, 6, 9, 1, 3, 2, 5, 8));

   -- Check that Inv(Inv(j)) == j
   pragma Assert(for all J in Digit_Number => Inv(Inv(J)) = J);
   
   -- Check that D(j, Inv(j)) = 0
   pragma Assert(for all J in Digit_Number => D(J, Inv(J)) = 0);
   
   -- Check that P(i+j, n) = P(i, P(j, n))
   pragma Assert(for all I in Digit_Number =>
                    (for all J in Digit_Number =>
                        (for all N in Digit_Number =>
                            P((I+J) mod 8, N) = P(I mod 8, P(J mod 8, N))
                        )
                    )
                    
                );
   
   function To_Digit_Number(Value : in Digit_Character) return Digit_Number
   is (Digit_Number(Digit_Character'Pos(Value) - Digit_Character'Pos('0')))
   with Inline;
   
   function To_Digit_Character(Value : in Digit_Number) return Digit_Character
   is (Digit_Character'Val(Digit_Character'Pos('0') + Integer(Value)))
   with Inline;
   
   function Compute_Verhoeff(Seq     : in String;
                             Initial : in Digit_Character) return Digit_Number
     with Pre => (for all I in Seq'Range => (Seq(I) in Digit_Character))
   is
      C : Digit_Number := To_Digit_Number(Initial);
      I : Natural      := 0;
      X : Natural      := Seq'Length;
   begin
      while X > 0 loop
         pragma Loop_Variant(Decreases => X);
         pragma Loop_Invariant((I+X) = Seq'Length);
         
         I := I + 1;
         X := X - 1;
         C := D(C, P(Digit_Number(I mod 8), To_Digit_Number(Seq(Seq'First + X))));
      end loop;
      
      return C;
   end Compute_Verhoeff;
   
   
   
   function Check_Digit(Seq : in String) return Digit_Character
   is
   begin
      return To_Digit_Character(Inv(Compute_Verhoeff(Seq, '0')));
   end Check_Digit;
   
   
   
   function Is_Valid(Seq : in String) return Boolean
   is
   begin
      return 0 = Compute_Verhoeff(Seq(Seq'First .. Seq'Last - 1), Seq(Seq'Last));
   end Is_Valid;

end Verhoeff;
