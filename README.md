# BadSignal
Just another signal module with some additions from me
<table>
  <tr>
    <th>Function</th>
    <th>Arguments</th>
    <th>Info</th>
  </tr>
  
  <tr>
    <td>new</td>
    <td>
      <table>
        <tr>
          <th>Name</th>
          <th>Type</th>
          <th>Optional</th>
          <th>Description</th>
        </tr>
        <tr>
          <th>self</th>
          <th>Event</th>
          <th>No</th>
          <th>
            Mostly used for internals, shouldn't be set directly<br>
            so instead call the function by Event:new()
          </th>
        </tr>
        <tr>
          <th>alloc</th>
          <th>number</th>
          <th>Yes, default is 10</th>
          <th>
            Specify the amount of slots to instantly allocate.<br>
            use it if you connect a lot of functions once
          </th>
        </tr>
      </table>
    </td>
    <td>Creates a new Event object</td>
  </tr>
  
  <tr>
    <td>Push</td>
    <td>
      <table>
        <tr>
          <th>Name</th>
          <th>Type</th>
          <th>Optional</th>
          <th>Description</th>
        </tr>
        <tr>
          <th>self</th>
          <th>Event</th>
          <th>No</th>
          <th>
            Mostly used for internals, shouldn't be set directly<br>
            so instead call the function by Event:Push()
          </th>
        </tr>
        <tr>
          <th>yieldCall</th>
          <th>boolean</th>
          <th>No</th>
          <th>
            Specify if the function you are connecting uses <br>
            libraries like coroutine,task on itself. <br>
            Set to false if you are not using any of these <br>
            to optimize the calls by quite a bit
          </th>
        </tr>
        <tr>
          <th>func</th>
          <th>((...any) -> ())|thread</th>
          <th>No</th>
          <th>
            Function or thread you want to connect, <br>thread will only run once
          </th>
        </tr>
      </table>
    </td>
    <td>Pushes the event onto the event stack</td>
    <tr>
    <td>Pop</td>
    <td>
      <table>
        <tr>
          <th>Name</th>
          <th>Type</th>
          <th>Optional</th>
          <th>Description</th>
        </tr>
        <tr>
          <th>self</th>
          <th>Event</th>
          <th>No</th>
          <th>
            Mostly used for internals, shouldn't be set directly<br>
            so instead call the function by Event:Pop()
          </th>
        </tr>
        <tr>
          <th>func</th>
          <th>((...any) -> ())|thread</th>
          <th>No</th>
          <th>
            Functions/thread to pop
          </th>
        </tr>
      </table>
    </td>
    <td>Pops the function/thread from the event stack</td>
  </tr>
    <tr>
    <td>Await</td>
    <td>
      <table>
        <tr>
          <th>Name</th>
          <th>Type</th>
          <th>Optional</th>
          <th>Description</th>
        </tr>
        <tr>
          <th>self</th>
          <th>Event</th>
          <th>No</th>
          <th>
            Mostly used for internals, shouldn't be set directly<br>
            so instead call the function by Event:Await()
          </th>
        </tr>
      </table>
    </td>
    <td>Yields and returns arguments passed by Event:Fire()</td>
  </tr>
  <tr>
    <td>Once</td>
    <td>
      <table>
        <tr>
          <th>Name</th>
          <th>Type</th>
          <th>Optional</th>
          <th>Description</th>
        </tr>
        <tr>
          <th>self</th>
          <th>Event</th>
          <th>No</th>
          <th>
            Mostly used for internals, shouldn't be set directly<br>
            so instead call the function by Event:Once()
          </th>
        </tr>
        <tr>
          <th>func</th>
          <th>((...any) -> ())|thread</th>
          <th>No</th>
          <th>
            Function you want to connect once
          </th>
        </tr>
      </table>
    </td>
    <td>Acts similarly to Event:Push() except only running the function once</td>
  </tr>
  <tr>
    <td>Fire</td>
    <td>
      <table>
        <tr>
          <th>Name</th>
          <th>Type</th>
          <th>Optional</th>
          <th>Description</th>
        </tr>
        <tr>
          <th>self</th>
          <th>Event</th>
          <th>No</th>
          <th>
            Mostly used for internals, shouldn't be set directly<br>
            so instead call the function by Event:Fire()
          </th>
        </tr>
        <tr>
          <th>...</th>
          <th>...any</th>
          <th>Yes, accepts any amount of arguments</th>
          <th>
            Arguments you want to pass through
          </th>
        </tr>
      </table>
    </td>
    <td>Fires all of the functions/threads connected and passes the arguments to them</td>
  </tr>
  <tr>
    <td>PrepareGC</td>
    <td>
      <table>
        <tr>
          <th>Name</th>
          <th>Type</th>
          <th>Optional</th>
          <th>Description</th>
        </tr>
        <tr>
          <th>self</th>
          <th>Event</th>
          <th>No</th>
          <th>
            Mostly used for internals, shouldn't be set directly<br>
            so instead call the function by Event:Fire()
          </th>
        </tr>
      </table>
    </td>
    <td>Cleans all of connections by closing them and itself</td>
  </tr>
</table>
