
- CDN, why use, why react use
- why are we writing crossorigin 
- what is react and react-dom
  - why needs two files,


## Igniting our apps

- Apart from cdn another way to get react in our codebase
- before one push the code to the production 
  - bundling , codespliting, chunking, image optimization , minify , compress
- npm : not node package manager (not have a full form)
- need for module in script tag; (to use import from node_modules)
- Package.json is configuration for npm(version manager)
  - npm init
  - dependencies
  - bundler : webpack, parcel, vite etc
    - dev dependencies(only require when developing ie by developer like bundler) and normal dependencies
    - npm i -D (-D: as a dev dependencies)
    - parcel bundler
    - caret^ and tilde~ in package.json
    - ^2.8.3 (only update minor version 8.3),~ major2->3
    - package-lock.json (keep track exact version)(keeps hash (integrity)) 
    - TRANSITIVE DEPENDENCIES
    - npm install : to download all package.json with dependencies file
    - package-lock.json contains all the transitive and all the dependecies     
    - .gitignore, include /node_modules in it
  
  - npx - executing a package
  - should be on server - **port**
  
  - PARCEL
    - Dev Build
    - Local Server
    - **HMR** = Hot Module Replacement
      - File Watching algo - written in cpp
    - Caching - Faster Bulds (.parcel-cache)
    - Image optimization
    - Minification (npx parcel build ...)
    - Bundling
    - Compress
    - Consistent Hashing
    - Code Splitting
    - Differential Bundling - support older browsers
    - Beautiful Diagnostic & (Error Handling)
    - HTTPs
    - Tree Shaking - remove unused code
    - Different dev and prod bundles npx parcel build <file> (production based )
    --- more and more --- 

  - browserlist - tells the project how much browser should support (already downloaded as a dependencies of many)
    - search on browser
    - in package.json
     ```json
      "browserslist": [
        "last 6 Chrome version",
        "last 2 version"
      ] 
      ```


