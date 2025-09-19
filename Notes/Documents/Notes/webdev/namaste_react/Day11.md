# Optimising React app

- useCustomHooks
  - 1st check what to accept and what to return
  - Make api call hook(useRestaurantMenu)
  - Make useOnlineStatus

- One file -> large size
  - Therefore split it
  
## Chunking, Code Splitting, lazy lOading, Dynamic bundling, On demand loading,Dynamic import
(lazy - loading react)
- How to do logical separation of bundle()
- { lazy } from "react"
- lazy(()=>{import ""})
### Suspense
- <Suspense fallback ={}><Lazy_Loading_element></Suspense>
