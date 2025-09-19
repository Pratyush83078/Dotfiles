# Use effect

```javascript
useEffect((
   
),[]) // 2nd args is dependencies 
// useEffect will be called when react renders
```
- dependencie array empty = > use effect will call only once(1st render)
- dependencies array not present => will call in every render
- if dependencies array (has some value (ie state variable etc))
  - then if that changes then it trigger

- CORS policy - if origin mismatch browser blocks that api call. 
  - How to bypass (Allow CORS-(chrome extension))
  - Shimmer UI

- Whenever state variable update, rect triggers a reconciliation cycle(re-reders the component)(react fibre (new reconcilation algorithm) finds difference b/w two virtual dom and update the Dom only which requires)

