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

  def area(polygon) do
    alias Collision.Polygon.Edge
    area = Enum.map(polygon.edges, fn %Edge{point: point, next: next} ->
      point.x * next.y - point.y * next.x
    end)
    |> Enum.sum
    abs(area / 2)
  end
end
