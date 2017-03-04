defmodule Border.Room do
  use GenServer

  alias Border.MatchState

  def start_link(_params \\ []) do
    GenServer.start_link(__MODULE__, MatchState.new())
  end

  def join(pid, id) do
    GenServer.call(pid, {:join, id})
  end

  def add_vertex(pid, user_id, vertex) do
    GenServer.call(pid, {:add_vertex, user_id, vertex})
  end

  def state(pid) do
    GenServer.call(pid, :fetch)
  end

  def handle_call({:join, id}, _from, state) do
    state = MatchState.add_user(state, id)
    {:reply, state, state}
  end

  def handle_call({:add_vertex, user_id, vertex}, _from, state) do
    state = MatchState.add_vertex(state, user_id, vertex)
    {:reply, state, state}
  end

  def handle_call(:fetch, _from, state) do
    {:reply, state, state}
  end
end
