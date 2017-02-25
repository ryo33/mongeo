defmodule Border.LineTest do
  use ExUnit.Case
  alias Border.Line

  test "crossing" do
    assert Line.crosses?({-1, -1}, { 1, 1}, {-1, 1}, { 1, -1})
  end

  test "not crossing" do
    refute Line.crosses?({0, 0}, { 1, 0}, {0, 1}, { 1, 0.5})
  end

  test "one point is on the other line" do
    assert Line.crosses?({-1, 0}, { 1, 0}, {0, 0}, { 0, 1})
  end

  test "one point is in the same coordinates" do
    assert Line.crosses?({0, 0}, { 1, 0}, {0, 0}, { 0, 1})
    assert Line.crosses?({0, 0}, { 1, 0}, {0, 1}, { 0, 0})
    assert Line.crosses?({0, 0}, { 1, 0}, {1, 0}, { 1, 1})
    assert Line.crosses?({0, 0}, { 1, 0}, {1, 1}, { 1, 0})
  end

  test "two points are in the same coordinates" do
    assert Line.crosses?({0, 0}, { 1, 1}, {0, 0}, { 1, 1})
  end

  test "parallel" do
    assert Line.crosses?({-1, 0}, {1, 0}, {0, 0}, {2, 0})
    assert Line.crosses?({-2, 0}, {2, 0}, {-1, 0}, {1, 0})
    refute Line.crosses?({-2, 0}, {-1, 0}, {1, 0}, {2, 0})
  end
end
