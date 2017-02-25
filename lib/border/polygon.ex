defmodule Border.Polygon do
  alias Collision.Polygon.Vertex
  alias Collision.Polygon
  alias Collision.Detection.SeparatingAxis

  def new(list) do
    list
    |> Enum.map(fn {x, y} -> %Vertex{x: x, y: y} end)
    |> Polygon.from_vertices
  end

  def collision?(polygon1, polygon2) do
    SeparatingAxis.collision?(polygon1, polygon2)
  end
end
