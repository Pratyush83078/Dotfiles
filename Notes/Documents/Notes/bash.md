  - read -p "print input" variable
  - Arithmatic operation (floating value can't return)
      - expr $A + $B (space is necessary between operator +)
      - expr $A \* $B (to multiple two variable)
  - second method to multiply
    - echo $((A * B)) [or ++A like c]
  - for floating values
    - echo $A / $B | bc -l (use bc math utility)

# Conditional operation
    
  - if[ $A = "2"] 
    then 
      echo "x"
    fi


# Packages
    
  - sed , awk, cut
  - tr, jq
  - grep,ripgrep(rg), echo
  - wc, bc 
  - fd , find

# Advance Mode (sometimes to use cpp like syntax ie for for loop [[]])
  
  - [[]], (())
