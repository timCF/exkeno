defmodule ExkenoTest do
  use ExUnit.Case
  doctest Exkeno
  @win Enum.to_list(1..20)
  @balls Exkeno.Keno.Classic.balls
  @rest Enum.filter(@balls, &(not(&1 in @win)))

  test "paytable" do
    #1
    assert 3 == Enum.take(@win,1) |> Exkeno.Keno.Classic.win(@win)
    #2
    assert 1 == (Enum.take(@win,1) ++ Enum.take(@rest,1)) |> Exkeno.Keno.Classic.win(@win)
    assert 10 == Enum.take(@win,2) |> Exkeno.Keno.Classic.win(@win)
    #3
    assert 2 == (Enum.take(@win,2) ++ Enum.take(@rest,1)) |> Exkeno.Keno.Classic.win(@win)
    assert 45 == Enum.take(@win,3) |> Exkeno.Keno.Classic.win(@win)
    #4
    assert 1 == (Enum.take(@win,2) ++ Enum.take(@rest,2)) |> Exkeno.Keno.Classic.win(@win)
    assert 10 == (Enum.take(@win,3) ++ Enum.take(@rest,1)) |> Exkeno.Keno.Classic.win(@win)
    assert 80 == Enum.take(@win,4) |> Exkeno.Keno.Classic.win(@win)
    #5
    assert 1 == (Enum.take(@win,2) ++ Enum.take(@rest,3)) |> Exkeno.Keno.Classic.win(@win)
    assert 3 == (Enum.take(@win,3) ++ Enum.take(@rest,2)) |> Exkeno.Keno.Classic.win(@win)
    assert 20 == (Enum.take(@win,4) ++ Enum.take(@rest,1)) |> Exkeno.Keno.Classic.win(@win)
    assert 150 == Enum.take(@win,5) |> Exkeno.Keno.Classic.win(@win)
    #6
    assert 2 == (Enum.take(@win,3) ++ Enum.take(@rest,3)) |> Exkeno.Keno.Classic.win(@win)
    assert 15 == (Enum.take(@win,4) ++ Enum.take(@rest,2)) |> Exkeno.Keno.Classic.win(@win)
    assert 60 == (Enum.take(@win,5) ++ Enum.take(@rest,1)) |> Exkeno.Keno.Classic.win(@win)
    assert 500 == Enum.take(@win,6) |> Exkeno.Keno.Classic.win(@win)
    #7
    assert 1 == (Enum.take(@win,0) ++ Enum.take(@rest,7)) |> Exkeno.Keno.Classic.win(@win)
    assert 2 == (Enum.take(@win,3) ++ Enum.take(@rest,4)) |> Exkeno.Keno.Classic.win(@win)
    assert 4 == (Enum.take(@win,4) ++ Enum.take(@rest,3)) |> Exkeno.Keno.Classic.win(@win)
    assert 20 == (Enum.take(@win,5) ++ Enum.take(@rest,2)) |> Exkeno.Keno.Classic.win(@win)
    assert 80 == (Enum.take(@win,6) ++ Enum.take(@rest,1)) |> Exkeno.Keno.Classic.win(@win)
    assert 1000 == Enum.take(@win,7) |> Exkeno.Keno.Classic.win(@win)
    #8
    assert 1 == (Enum.take(@win,0) ++ Enum.take(@rest,8)) |> Exkeno.Keno.Classic.win(@win)
    assert 5 == (Enum.take(@win,4) ++ Enum.take(@rest,4)) |> Exkeno.Keno.Classic.win(@win)
    assert 15 == (Enum.take(@win,5) ++ Enum.take(@rest,3)) |> Exkeno.Keno.Classic.win(@win)
    assert 50 == (Enum.take(@win,6) ++ Enum.take(@rest,2)) |> Exkeno.Keno.Classic.win(@win)
    assert 200 == (Enum.take(@win,7) ++ Enum.take(@rest,1)) |> Exkeno.Keno.Classic.win(@win)
    assert 2000 == Enum.take(@win,8) |> Exkeno.Keno.Classic.win(@win)
    #9
    assert 2 == (Enum.take(@win,0) ++ Enum.take(@rest,9)) |> Exkeno.Keno.Classic.win(@win)
    assert 2 == (Enum.take(@win,4) ++ Enum.take(@rest,5)) |> Exkeno.Keno.Classic.win(@win)
    assert 10 == (Enum.take(@win,5) ++ Enum.take(@rest,4)) |> Exkeno.Keno.Classic.win(@win)
    assert 25 == (Enum.take(@win,6) ++ Enum.take(@rest,3)) |> Exkeno.Keno.Classic.win(@win)
    assert 125 == (Enum.take(@win,7) ++ Enum.take(@rest,2)) |> Exkeno.Keno.Classic.win(@win)
    assert 1000 == (Enum.take(@win,8) ++ Enum.take(@rest,1)) |> Exkeno.Keno.Classic.win(@win)
    assert 5000 == Enum.take(@win,9) |> Exkeno.Keno.Classic.win(@win)
    #10
    assert 2 == (Enum.take(@win,0) ++ Enum.take(@rest,10)) |> Exkeno.Keno.Classic.win(@win)
    assert 5 == (Enum.take(@win,5) ++ Enum.take(@rest,5)) |> Exkeno.Keno.Classic.win(@win)
    assert 30 == (Enum.take(@win,6) ++ Enum.take(@rest,4)) |> Exkeno.Keno.Classic.win(@win)
    assert 100 == (Enum.take(@win,7) ++ Enum.take(@rest,3)) |> Exkeno.Keno.Classic.win(@win)
    assert 300 == (Enum.take(@win,8) ++ Enum.take(@rest,2)) |> Exkeno.Keno.Classic.win(@win)
    assert 2000 == (Enum.take(@win,9) ++ Enum.take(@rest,1)) |> Exkeno.Keno.Classic.win(@win)
    assert 10000 == Enum.take(@win,10) |> Exkeno.Keno.Classic.win(@win)
    # zero
    assert true == Enum.all?(1..6, &(0 == (Enum.take(@rest,&1) |> Exkeno.Keno.Classic.win(@win))))
    assert true == Enum.all?(3..10, &(0 == ((Enum.take(@win,1) ++ Enum.take(@rest,&1-1)) |> Exkeno.Keno.Classic.win(@win))))
    assert true == Enum.all?(6..10, &(0 == ((Enum.take(@win,2) ++ Enum.take(@rest,&1-2)) |> Exkeno.Keno.Classic.win(@win))))
    assert true == Enum.all?(8..10, &(0 == ((Enum.take(@win,3) ++ Enum.take(@rest,&1-3)) |> Exkeno.Keno.Classic.win(@win))))
    assert true == Enum.all?(10..10, &(0 == ((Enum.take(@win,4) ++ Enum.take(@rest,&1-4)) |> Exkeno.Keno.Classic.win(@win))))
  end

  test "validation" do
    assert true == Enum.all?(1..10, fn(n) -> Enum.take(@balls, n) |> Exkeno.Keno.Classic.valid? end)
    assert false == Exkeno.Keno.Classic.valid?([81])
    assert false == Exkeno.Keno.Classic.valid?([8.1])
    assert false == Exkeno.Keno.Classic.valid?(["80"])
    assert false == Exkeno.Keno.Classic.valid?(80)
  end

end
