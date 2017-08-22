defmodule Exkeno.Keno.Classic2.Macro do
  defmacro __using__(_) do
    quote location: :keep do
      use Exkeno, [
        balls: unquote(Enum.to_list(1..80)),
        winlen: 20,
        paytable: %{
          1 => %{
            1 => 3.6,
          },
          2 => %{
            1 => 1,
            2 => 9,
          },
          3 => %{
            2 => 2,
            3 => 45,
          },
          4 => %{
            2 => 1,
            3 => 10,
            4 => 90,
          },
          5 => %{
            2 => 1,
            3 => 3,
            4 => 27,
            5 => 100,
          },
          6 => %{
            3 => 2,
            4 => 15,
            5 => 60,
            6 => 500,
          },
          7 => %{
            0 => 1,
            3 => 2,
            4 => 4,
            5 => 20,
            6 => 80,
            7 => 1000,
          },
          8 => %{
            0 => 1,
            4 => 5,
            5 => 15,
            6 => 50,
            7 => 200,
            8 => 2000,
          },
          9 => %{
            0 => 2,
            4 => 2,
            5 => 10,
            6 => 25,
            7 => 125,
            8 => 1000,
            9 => 5000,
          },
          10 => %{
            0 => 2,
            5 => 5,
            6 => 30,
            7 => 100,
            8 => 300,
            9 => 2000,
            10 => 10000,
          },
        },
        debug: false
      ]
    end
  end
end

defmodule Exkeno.Keno.Classic2 do
  use Exkeno.Keno.Classic2.Macro
end
