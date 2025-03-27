--[[
  Copyright 2025 Arsenij Ivashenko

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
]]

--!optimize 2
--!strict

--Creates a new event
local function Event_new(self:Event,alloc:number?) : Event
	local newSelf = table.clone(self)
	newSelf._queue = table.create(alloc or 10)::{any}
	newSelf._yieldHash = {}
	return newSelf
end

--Pushes the func onto the event stack, if the provided argument is a thread then it will run it once
local function Event_Push(self:Event,yieldCall:boolean,func:((...any) -> ())|thread) : ()
	local queue = self._queue
	local pos = #queue+1
	queue[pos] = func
	if yieldCall and type(func) == "function" then
		self._yieldHash[func] = true
	end
end

--Pops the func from the stack
local function Event_Pop(self:Event,func:((...any) -> ())|thread) : ()
	local queue = self._queue
	local threadPos = table.find(queue,func)
	if threadPos then
		table.remove(queue,threadPos)
		self._yieldHash[func::any] = nil
	end
end

--Equal to Event:Push(coroutine.running()) local returnArgs = coroutine.yield() altrough a bit faster
local function Event_Await(self:Event) : ...any
	table.insert(self._queue,coroutine.running())
	return coroutine.yield()
end

--Equal to Event:Push(coroutine.create(function(args) end))
local function Event_Once(self:Event,func:(...any) -> ()) : ()
	Event_Push(self,false,coroutine.create(func))
end

--Fires all of the events, ... is used for custom args to give to the events
local function Event_Fire(self:Event,...) : ()
	local queue = self._queue
	local yieldHash = self._yieldHash
	for i = #queue,1,-1 do
		local v = queue[i]
		if type(v) == "function" then
			if yieldHash[v] then
				coroutine.resume(coroutine.create(v),...)
			else
				xpcall(v,warn::(...any) -> (),...)
			end
		else
			coroutine.resume(v::thread,...)
			table.remove(queue,i)
		end
	end
end

--Cleans all of connections and prepares object for garbage collection
local function Event_PrepareGC(self:Event) : ()
	for i,v in self._queue do
		if type(v) == "thread" then
			coroutine.close(v)
		end
	end
	table.clear(self._queue)
	table.clear(self._yieldHash)
	table.clear(self::{[any]:any})
end

export type Event = {
	new:typeof(Event_new);
	Push:typeof(Event_Push);
	Await:typeof(Event_Await);
	Once:typeof(Event_Once);
	Pop:typeof(Event_Pop);
	Fire:typeof(Event_Fire);
	PrepareGC:typeof(Event_PrepareGC);
	
	_queue:{((...any) -> ())|thread};
	_yieldHash:{[(...any) -> ()]:boolean};
}

local Event:Event = {
	new = Event_new;
	Push = Event_Push;
	Await = Event_Await;
	Once = Event_Once;
	Pop = Event_Pop;
	Fire = Event_Fire;
	PrepareGC = Event_PrepareGC;
	
	_queue = {};
	_yieldHash = {};
}

return Event
