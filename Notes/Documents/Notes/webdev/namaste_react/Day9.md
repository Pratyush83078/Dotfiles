# Class based component (lets' get classy)


- never update State Variable directly
- this.setState({count: this.state.count+1})
- LifeCycle of class based component
  - componentDidMount()

- componentDidMount() is similarly use inplace of useEffect() [ api call]

## React lifecycle diagram
- life cycle method are called differently when there are multiple children
- React is optimising
- React batches these childs so first for them render phase happens then commit phase happens
- means only after rendering them React updates the dom

- In render phase (reconcilation happens(diff algo)) (React don't access Dom as Dom manipulation is expensive)
- In commit phase React updates (DOM - IN single batch)


- debugger;

## Mounting, Updating, Unmounting (lifecycle of react component(object(instance of React.Component)))

- Mounting: When 1st appear on ui (constructor, render, commit)=> componentDidMount()
- Updating: After creating (the object) then when component(re-render,commit etc)=> componentDidUpdate() 
- Unmounting: When Component unmount(ie when we go to another page(react is single paged application) (it just unmount and mount the page component) etc)=> ComponentWillUnmount()


- useEffect is not equal to componentDidMount()
  they are completely different
- so don't compare functional based and class based component

- At first we used to write class based component
  - we used to use componentDidUpdate(prevProps, prevState)
    - if else etc
  - but now we use useEffect (depedencies)


# Problems of single paged ui

- as if we set a setInterval in a component 
  then moving through another page (homme,aboutetc)
  it don't refresh, ie it runs,
- And after visiting each time that page it trigger
  more(it adds one more) setInterval

- Therefore we can fix it using ComponentWillUnmount(){clearInterval(this.timer)}
  if this.timer is referencing to that setInterval

- USEFFECT DOESN'T DO THIS IT DOESN'T CLEAR THE MESS THAT YOU'LL CREATE

## Unmounting phase in useEffect react hook

  ```javascript
  useEffect(()=>
  const timer=setInterval(()=>{},1000)
  return () =>{
      clearinterval(timer)
      console.log("useEffect unmounted (returned)")
    }
  )  
  ```

- Now we have studied 5 life cycle method in react
- But when react was new then there were even more life cycle method that were depriciated early 

# Questions

- Why we use super keyword
- Why we don't use async inside useEffect(we use directly await)  
- Read what error react give on using async function inside them
