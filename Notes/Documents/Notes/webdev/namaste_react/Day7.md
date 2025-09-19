
- use state : used for creating local variable inside function component;
  - There fore usestate variable only allowed inside funcn/Component
  - don't use in if else/loops/nested function(create inconsistency)

# React-router-dom
- import { createBrowserRouter }
  createBrowserRounter([
{}
])
rafce

- errorElement
- useRouteError from react-router-dom
- outlet and children:
- should not use anchor tag
  - as whole page goes refresh
  - But how to navigate different page without complete refresh
    - use <Link to=""></Link>(from react-router-dom)
    - behind the seen Link is also using anchor tag(wrapper over a tag)
    - 
    - it just refreshes the component
    - THEREFORE IT REACT APPLICATION IS KNOWN AS SINGLE PAGE APPLICATION
    - Everthing is component in react

## Types of Routing in web apps

- Client Side Routing
- Server Side Routing (make call to backend)

## Dynamic Routing(for every restaurant)

- in react-route-dom use /:resid (resid is dynampic path)
- Graphql: as we get so many data(from api) but sometimes we need only small (here graphql comes into play)
- userParams (hook from react-router-dom)
  - 
