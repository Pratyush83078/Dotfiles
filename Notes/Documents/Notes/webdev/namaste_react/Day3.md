# React

- to put inline style in jsx use jsx object
### Props
-  passing a prop to a function is like passing a arg to a func
-  when you have to dynamically pass data to a component we use props
- destructuring on the fly, destructuring in js obj
- Config driven ui (our website is driven by config)
    - controlling ui using data(config), comes from backend ie in swiggy for every city  they have to change their ui (frontend)(json).

- Cloudinary, when you see res.cloudinary.com/ you should know that it is using cdn cloudinary
- ?. optional chaining in js
- use, map, reduce instead of for as functional programming is good practice okay 

#### error
-  GIVE A KEY WHENEVER YOU MAP ETC AS ALL ELEM SHOULD BE DIFFERENT THEREFORE USE (unique) key="" (huge optimization)
- Each child in a list should have a unique "key"
- As react doesn't know at which place put the card etc.. so i have to re render the object(cleans the container and re-render all the cards(it will treat all the restaurant card to the same))
- react itself recommend never use index as a key (anti-pattern)
- index as a key is an anti-pattern
### file structure
### importing and exporting
- export default <NameOfComp>
- import <anyNameAsWeAreUsingDefault> "file_path (.js can be omit)" 
- therefore only one default for one file
- FOR MULTIPLE THINGS FROM SAME FILE
  - use Named export
  - export const VARIABLE_NAME
  - import { EXACT_NAME } from "file_path"
- file should not exceed 400 lines (best practice)

# REACT MAIN FEATURE
- IF MY DATA CHANGES MY UI CHANGES
 ## REACT HOOK
  - (normal written js function)
  - imp hooks
    - useState()- Superpowerful state Variables in react 
      - import {useState} from "react"
      - const [variable,setvariable]=useState(<ValueForVariable>);//use set before variable name (convention)
      - to change it we use setvar(<ValueForVar>)
      - Now OUR variable IS SYNC WITH that (component)UI- means if variable changes then (if ui is using that variable)
      then ui also changes
      - as soon as variable changes it automatically refreshes our component
      - this is known as RENDER
      - Whenver a statevariable update react will re-render my component (in which it is )
      - Not only that component gets updated where that statevariable lies okay therefore reduces so much complexity okay
      - MEANS IT MAKES DOM OPERATION SUPERFAST & EFFICIENT
    - useEffect()


# SOME JARGONS
- The logic of updating dom (ui) is known as re-rendering and this is where react is best
- React is good at DOM-Manipulation
- very fast update (using React hooks(useState))
