defmodule Border.MatchStateTest do
  use ExUnit.Case

  alias Border.Polygon
  alias Border.MatchState
  alias Border.MatchState.User
  alias Border.MatchState.Area

  test "add_user" do
    state = MatchState.new
            |> MatchState.add_user(0)
            |> MatchState.add_user(1)
    assert state.users[0] == User.new(0)
    assert state.users[1] == User.new(1)
  end

  test "add_vertex" do
    state = MatchState.new
            |> MatchState.add_user(0)
            |> MatchState.add_user(1)
            |> MatchState.add_vertex(0, {3, 1})
            |> MatchState.add_vertex(0, {3, 3})
            |> MatchState.add_vertex(1, {1, 2})
            |> MatchState.add_vertex(1, {4, 2})
            |> MatchState.add_vertex(0, {3, 4})
            |> MatchState.add_vertex(1, {4, 0})
            |> MatchState.add_vertex(1, {2, 0})
            |> MatchState.add_vertex(1, {2, 3})
    assert state.users[0].score == 0
    assert state.users[1].score == 4
    assert state.users[0].vertexes == [{3, 4}, {3, 3}]
    assert state.users[1].vertexes == [{2, 3}]
    assert Map.size(state.areas) == 1
    area = Map.get(state.areas, 0)
    assert area.id == 0
    assert area.user_id == 1
    assert area.area == 4
  end
end
