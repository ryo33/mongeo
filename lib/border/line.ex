defmodule Border.Line do
  def crosses?({x1, y1}, {x2, y2}, {x3, y3}, {x4, y4}) do
    outer = if x1 >= x2 do
      (x1 < x3 and x1 < x4) or (x2 > x3 and x2 > x4)
    else
      (x2 < x3 and x2 < x4) or (x1 > x3 and x1 > x4)
    end or if y1 >= y2 do
      (y1 < y3 and y1 < y4) or (y2 > y3 and y2 > y4)
    else
      (y2 < y3 and y2 < y4) or (y1 > y3 and y1 > y4)
    end
    if outer do
      false
    else
      if (x1 == x3 and y1 == y3) or (x1 == x4 and y1 == y4)
      or (x2 == x3 and y2 == y3) or (x2 == x4 and y2 == y4) do
        true
      else
        a = (x1 - x2) * (y3 - y1) + (y1 - y2) * (x1 - x3) >= 0.0
        b = (x1 - x2) * (y4 - y1) + (y1 - y2) * (x1 - x4) > 0.0
        c = (x3 - x4) * (y1 - y3) + (y3 - y4) * (x3 - x1) >= 0.0
        d = (x3 - x4) * (y2 - y3) + (y3 - y4) * (x3 - x2) > 0.0
        ((a and !b) or (!a and b)) and ((c and !d) or (!c and d))
      end
    end
  end
end
