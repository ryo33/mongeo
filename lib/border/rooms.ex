defmodule Border.Rooms do
  use GenServer

  def start_link(_params \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def register(key, pid) do
    GenServer.cast(__MODULE__, {:register, key, pid})
  end

  def pid(key) do
    GenServer.call(__MODULE__, {:pid, key})
  end

  def handle_cast({:register, key, pid}, state) do
    {:noreply, Map.put(state, key, pid)}
  end

  def handle_call({:pid, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end
end
