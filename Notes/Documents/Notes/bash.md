  - read -p "print input" variable
  - Arithmatic operation (floating value can't return)
      - expr $A + $B 
      - expr $A \* $B (to multiple two variable)
  - second method to multiply
    - echo $((A * B)) [or ++A like c]
  - for floating values
    - echo $A / $B | bc -l (use bc math utility)
    
