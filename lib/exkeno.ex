defmodule Exkeno do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Exkeno.Worker.start_link(arg1, arg2, arg3)
      # worker(Exkeno.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exkeno.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # paytable is nested map, like %{choisen1 => %{match1 => x, ...}, ...}
  #%{
  #  2 => %{
  #    1 => 1,
  #    ...
  #  },
  #  ...
  #}
  defmacro __using__([balls: balls = [_|_], winlen: winlen, paytable: pt, debug: debug]) when (is_integer(winlen) and (winlen > 0) and (length(balls) >= winlen) and is_boolean(debug)) do
    {paytable = %{}, []} = Code.eval_quoted(pt)
    choisen_lst = Map.keys(paytable)
    ballsmap = Enum.reduce(balls, %{}, &(Map.put(&2, &1, true)))
    #
    # just compile-time checks what keno config is valid
    #
    true = Enum.all?(balls, &is_integer/1) and (length(balls) == length(Enum.uniq(balls)))
    true = Enum.all?(paytable, fn({choisen, match_map = %{}}) ->
      if (length(balls) == winlen) and (choisen == winlen), do: raise("wrong winlen / choisen param")
      is_integer(choisen) and (choisen > 0) and (choisen <= winlen) and check_match(choisen, match_map)
    end)
    res = quote location: :keep do

            def win(bet = [_|_], wincombo = [_|_]) when (length(bet) in unquote(choisen_lst)) and (length(wincombo) == unquote(winlen)) do
              winmap = Enum.reduce(wincombo, %{}, &(Map.put(&2, &1, true)))
              matched = Enum.reduce(bet, 0, fn(n, acc) ->
                          case Map.has_key?(winmap, n) do
                            true -> acc + 1
                            false -> acc
                          end
                        end)
              case get_in(unquote(pt), [length(bet), matched]) do
                nil -> 0
                num -> num
              end
            end

            def valid?(bet = [_|_]) do
              Enum.all?(bet, &(Map.has_key?(unquote(Macro.escape(ballsmap)), &1))) and (length(bet) == length(Enum.uniq(bet)))
            end
            def valid?(_), do: false

            def balls, do: unquote(balls)
            def winlen, do: unquote(winlen)
            def paytable, do: unquote(pt)

          end
    if (debug), do: (Macro.to_string(res) |> IO.puts)
    res
  end

  #
  # just compile-time checks what keno config is valid
  #
  defp check_match(choisen, match_map = %{}) do
    true = Enum.all?(match_map, fn({matched, payout}) ->
      is_integer(matched) and (matched >= 0) and is_number(payout) and (payout >= 0) and (matched <= choisen)
    end)
  end

end
