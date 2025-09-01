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
  - (()) : for c like syntax inside a==b etc;(only integer)
  - [[]] : preferred as it is mix of bash and popular programming language

  - | Form        | Use case                                                    |
    | ----------- | ----------------------------------------------------------- |
    | `[ ]`       | POSIX standard, use for portability. Needs careful quoting. |
    | `[[ ]]`     | Bash/Zsh safer modern tests. Use by default in Bash.        |
    | `(( ))`     | Arithmetic conditions and math.                             |
    | no brackets | Use a command’s success/failure.                            | 


# Packages
    
  - sed , awk, cut
  - tr, jq
  - grep,ripgrep(rg), echo
  - wc, bc 
  - fd , find

# Advance Mode (sometimes to use cpp like syntax ie for for loop [[]])
  
  - [[]], (())
