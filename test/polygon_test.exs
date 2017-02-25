defmodule Border.PolygonTest do
  use ExUnit.Case
  alias Border.Polygon

  test "collision" do
    polygon1 = Polygon.new([{-3, -3}, {-1, -3}, {-1, -1}, {-3, -1}])
    polygon2 = Polygon.new([{3, 3}, {1, 3}, {1, 1}, {3, 1}])
    polygon3 = Polygon.new([{-2, -2}, {2, -2}, {2, 2}, {-2, 2}])
    refute Polygon.collision?(polygon1, polygon2)
    assert Polygon.collision?(polygon1, polygon3)
    assert Polygon.collision?(polygon2, polygon3)
  end
end
