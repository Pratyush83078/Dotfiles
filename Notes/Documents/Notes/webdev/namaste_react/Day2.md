- jsx is also developed by facebook
  - js syntax
  - jsx is different from react
  - jsx is not HTML in js it looks like html/ XML-like syntax
  - react and jsx obj are same you can console it
  - JSX (transpiled before it reaches the JS Engine by parcel - BABEL) babel isn't developed by facebook
  - JSX => React.createElement means it uses react therefore it is also a react element (babel transpile it)
  - transpiler vs compiler (what is babel?)
  - AST
  
  - if you give attribute to jsx use camelCase
    - class -> className
    - tabindex -> tabIndex
    - wrap it with paranthesis if you wanna write it in multiple lines
  - React Element
    - is just we read earlier (JSX transpiled) react element

## React component

  - class based component (old method)
  - functional component  (new method)

  1. React Functional Component
    - function_name (first letter capital)
    - if a function returning react element(of jsx syntax which eventually converted into react element)
    - 1st letter capital and should return 
    - to render don't use directly name of variable
      - use like <Variable_name />/ in this way babel will understand it is react functional component
    - COMPONENT COMPOSITION
      - also to include a component into component 
      - use <Component /> = <Component></Component>

# Js in JSX
- any piece of js can be execute in {}
- you can also use {react_elem}
- JSX sanitize script, it prevents cross site scripting attack
- therefore for react functional component we can also call function like {Component()}= <Component/>








