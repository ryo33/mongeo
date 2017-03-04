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

  test "area" do
    polygon1 = Polygon.new([{0, 0}, {1, 0}, {0, 1}])
    assert Polygon.area(polygon1) == 0.5

    polygon2 = Polygon.new([{0, 0}, {2, 0}, {2, 1}, {1, 1}, {1, 2},
                            {2, 2}, {2, 3}, {1, 3}, {0, 3}])
    assert Polygon.area(polygon2) == 5
  end
end
