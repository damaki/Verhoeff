package Verhoeff
   with SPARK_Mode => On
is
   subtype Digit_Character is Character range '0' .. '9';
   
   type Digit_String is array(Integer range <>) of Digit_Character;
   
   function Check_Digit(Seq : in Digit_String) return Digit_Character;
   -- Compute the verhoeff check digit on a sequence.
   
   function Is_Valid(Seq : in Digit_String) return Boolean
      with Pre => (Seq'Length > 0 
                   and
                   Seq'Last > Integer'First);
   -- Validate the check digit on a sequence.
   --
   -- The check digit must be the last digit in the sequence.

end Verhoeff;
