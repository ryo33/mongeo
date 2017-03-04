defmodule Border.MatchState do
  alias Border.Line
  alias Border.Polygon

  defmodule User do
    defstruct [:id, :score, :vertexes]
    def new(id) do
      %__MODULE__{
        id: id,
        score: 0,
        vertexes: []
      }
    end
  end

  defmodule Area do
    defstruct [:id, :vertexes, :polygon, :area, :user_id]
    def new(id, vertexes, polygon, user, areas) do
      area = Polygon.area(polygon)
      %__MODULE__{
        id: id,
        vertexes: vertexes,
        polygon: polygon,
        area: area - areas,
        user_id: user.id
      }
    end
  end

  alias __MODULE__.User
  alias __MODULE__.Area

  defstruct [:users, :areas, :outer_areas]

  def new do
    %__MODULE__{
      users: %{},
      areas: %{},
      outer_areas: %{}
    }
  end

  def add_user(state, id) do
    %__MODULE__{state | users: Map.put(state.users, id, User.new(id))}
  end

  def add_vertex(state, user_id, vertex) do
    # Cancelling
    user = Map.get(state.users, user_id)
    state = if length(user.vertexes) != 0 do
      handle_cancelling(state, user_id, vertex)
    else
      state
    end
    # Add a vertex
    users = Map.update!(state.users, user_id, fn user ->
      %User{user | vertexes: [vertex | user.vertexes]}
    end)
    state = %__MODULE__{state | users: users}
    # Occupying
    user = Map.get(state.users, user_id)
    # 4 vertexes is needed to create triangle
    state = if length(user.vertexes) >= 4 do
      handle_occupying(state, user_id)
    else
      state
    end
    state
  end

  defp handle_cancelling(state, user_id, vertex) do
    user = Map.get(state.users, user_id)
    previous_vertex = hd(user.vertexes)
    users = Enum.map(state.users, fn {id, user} ->
      if id != user_id do
        {id, handle_crossing(user, previous_vertex, vertex)}
      else
        {id, user}
      end
    end)
    |> Enum.into(%{})
    %__MODULE__{state | users: users}
  end

  defp handle_occupying(state, user_id) do
    user = Map.get(state.users, user_id)
    [v1 | [v2 | vertexes]] = user.vertexes
    line_seg = Enum.chunk(vertexes, 2, 1)
               |> Enum.with_index
               |> Enum.find(fn {[v3, v4], _i} -> Line.crosses?(v1, v2, v3, v4) end)
    if not is_nil(line_seg) do
      {[v3, v4], index} = line_seg
      crossing_point = Line.crossing_point(v1, v2, v3, v4)
      points = [crossing_point | [v2 | Enum.take(vertexes, index+1)]]
      polygon = Polygon.new(points)
      collided_area = 0 # TODO collision detection with other areas
      area_id = Map.size(state.areas) |> to_string
      area = Area.new(area_id, points, polygon, user, collided_area)
      areas = Map.put(state.areas, area_id, area)
      user = %User{user | vertexes: [v1]}
             |> Map.update!(:score, &(&1 + area.area))
      users = Map.put(state.users, user_id, user)
      %__MODULE__{state | users: users, areas: areas}
    else
      state
    end
  end

  defp handle_crossing(user, v1, v2) do
    crossing = Enum.chunk(user.vertexes, 2, 1)
               |> Enum.any?(fn [v3, v4] -> Line.crosses?(v1, v2, v3, v4) end)
    if crossing do
      %User{user | vertexes: [hd(user.vertexes)]}
    else
      user
    end
  end
end
