<img src="docs/Logo.png" alt="Bad Signal" width="512" height="512">

# BadSignal

## Just Another Signal Module with Custom Additions

### Function Reference

| Function      | Arguments                                                                                                                                                                                                                                                                                                                 | Description                                                     |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| **new**       | **self** (Event) - Used internally, should be called via `Event:new()`.<br>**alloc** (number, optional, default = 10) - Number of slots to allocate, useful for connecting multiple functions at once. Increasing this value reduces reallocation overhead when many functions are added dynamically.                         | Creates a new Event object.                                     |
| **Push**      | **self** (Event) - Used internally, should be called via `Event:Push()`.<br>**yieldCall** (boolean) - Set to `true` if the connected function uses coroutine/task libraries. Setting this incorrectly can impact performance.<br>**func** ((...any) -> ()) \| thread - Function or thread to connect. Threads will run only once. | Adds a function or thread to the event stack.                   |
| **Pop**       | **self** (Event) - Used internally, should be called via `Event:Pop()`.<br>**func** ((...any) -> ()) \| thread - Function or thread to remove.                                                                                                                                                                                | Removes a function or thread from the event stack.              |
| **Await**     | **self** (Event) - Used internally, should be called via `Event:Await()`.                                                                                                                                                                                                                                                 | Yields and returns arguments passed by `Event:Fire()`.          |
| **Once**      | **self** (Event) - Used internally, should be called via `Event:Once()`.<br>**func** ((...any) -> ()) \| thread - Function to connect.                                                                                                                                                                                        | Similar to `Push()`, but the function runs only once.           |
| **Fire**      | **self** (Event) - Used internally, should be called via `Event:Fire()`.<br>**...** (...any, optional) - Arguments to pass.                                                                                                                                                                                                   | Fires all connected functions/threads and passes the arguments. |
| **PrepareGC** | **self** (Event) - Used internally, should be called via `Event:PrepareGC()`.                                                                                                                                                                                                                                             | Cleans up all connections by closing them and itself.           |

### Additional Information

#### alloc Parameter

The `alloc` parameter determines the initial number of slots allocated for event connections. If many functions are expected to connect at once, setting this to a higher value can improve performance by reducing memory reallocation.

#### yieldCall Parameter

Most signal modules compromise between speed and thread safety. However, BadSignal fully wraps connected functions in threads, preventing issues when using `coroutine.yield()` or similar functions. While this improves stability, it introduces overhead.

To optimize execution, the `yieldCall` parameter allows you to specify if the function calls any yield operations. If it does not, execution speed improves significantly.

##### Functions Requiring `yieldCall = true`:

- `task.wait()`
- `task.delay(1, coroutine.running()) coroutine.yield()`
- `task.defer(coroutine.running()) coroutine.yield()`
- `coroutine.yield()`
- `RBXScriptSignal:Wait()`
- `Instance:WaitForChild("")`

These are only some examples—any function that suspends execution may require `yieldCall` to be set to `true`.

