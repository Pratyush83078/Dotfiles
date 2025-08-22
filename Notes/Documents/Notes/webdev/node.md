# Js
  - process.env.NUMBER (take input through terminal (enviromental method))
  - cpu bound tasks (ie for loop etc)
  - i/o operation :heavy operation 
    - eg reading a file starting a clock , https-request
  - concurrency vs parallelism
  - nodejs event loop can execute tasks cuncurrently
  - js engine is single threaded but by the help of outer 
    environment (web browser(web apis) or libuv library for node js)
    it achieves concurrency(on a single core), 
    but due to multithreading os we can run multiple tasks at once
  - when thread gets free only then callback queues get in js main engine.(stack)
  - microtask higher priority then callback queues(macro queues etc)
  - macrotask Queues(simple tasks queue)
    - setTimeout setInterval, I/O operations(networks req,reading,writing etc)
    - requestAnimationFrame setImmediate(node) ,events(click etc)
  - macrotask(or Job Queue)
    - Promises (their then,catch and finally callbacks)
    - queueMicrotask
    - process.nextTick
    - MutationObserver callbacks etc

# require("fs")
  - readFile("filePath",encoding,function(err,data))
  - readFileSync("filePath",encoding)



