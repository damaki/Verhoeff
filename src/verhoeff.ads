package Verhoeff
   with SPARK_Mode => On
is
   type Digit is new Natural range 0 .. 9;
   
   type Digit_Array is array(Integer range <>) of Digit;
   
   function Check_Digit(Seq : in Digit_Array) return Digit;
   -- Compute the verhoeff check digit on a sequence.
   
   function Is_Valid(Seq : in Digit_Array) return Boolean
   with Pre => Seq'Length > 0 and Seq'Last > Integer'First;
   -- Validate the check digit on a sequence.
   --
   -- The check digit must be the last digit in the sequence.

end Verhoeff;
