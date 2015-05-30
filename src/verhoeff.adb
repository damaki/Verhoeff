package body Verhoeff
   with SPARK_Mode => On
is

   D : constant array(Digit, Digit) of Digit :=
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
   
   Inv : constant array(Digit) of Digit :=
    (0, 4, 3, 2, 1, 5, 6, 7, 8, 9);
    
   P : constant array(Digit range 0 .. 7, Digit) of Digit :=
    ((0, 1, 2, 3, 4, 5, 6, 7, 8, 9),
     (1, 5, 7, 6, 2, 8, 3, 0, 9, 4),
     (5, 8, 0, 3, 7, 9, 6, 1, 4, 2),
     (8, 9, 1, 6, 0, 4, 3, 5, 2, 7),
     (9, 4, 5, 3, 1, 2, 6, 8, 7, 0),
     (4, 2, 8, 6, 5, 7, 3, 9, 0, 1),
     (2, 7, 9, 3, 8, 0, 6, 4, 1, 5),
     (7, 0, 4, 6, 9, 1, 3, 2, 5, 8));

   -- Check that Inv(Inv(j)) == j
   pragma Assert(for all J in Digit => Inv(Inv(J)) = J);
   
   -- Check that D(j, Inv(j)) = 0
   pragma Assert(for all J in Digit => D(J, Inv(J)) = 0);
   
   -- Check that P(i+j, n) = P(i, P(j, n))
   pragma Assert(for all I in Digit =>
                    (for all J in Digit =>
                        (for all N in Digit =>
                            P((I+J) mod 8, N) = P(I mod 8, P(J mod 8, N))
                        )
                    )
                    
                );
   
   function Compute_Verhoeff(Seq     : in Digit_Array;
                             Initial : in Digit) return Digit
   is
      C : Digit   := Initial;
      I : Natural := 0;
      X : Natural := Seq'Length;
   begin
      while X > 0 loop
         pragma Loop_Variant(Decreases => X);
         pragma Loop_Invariant((I+X) = Seq'Length);
         
         I := I + 1;
         X := X - 1;
         C := D(C, P(Digit(I mod 8), Seq(Seq'First + X)));
      end loop;
      
      return C;
   end Compute_Verhoeff;
   
   
   
   function Check_Digit(Seq : in Digit_Array) return Digit
   is
   begin
      return Inv(Compute_Verhoeff(Seq, 0));
   end Check_Digit;
   
   
   
   function Is_Valid(Seq : in Digit_Array) return Boolean
   is
   begin
      return 0 = Compute_Verhoeff(Seq(Seq'First .. Seq'Last - 1), Seq(Seq'Last));
   end Is_Valid;

end Verhoeff;
