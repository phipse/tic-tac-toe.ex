defmodule TicTacToe do
  @moduledoc """
  A simple tic tac toe game.
  """

  @doc """
  Tic Tac Toe game

  ## Examples

      iex> TicTacToe.start_game()

  """

  def print_field(f) do
    FieldManager.print_field(f)
  end

  def check_field(f, player) do
    case FieldManager.check_win(f, player) do
      {:win} -> {:win, "#{player} won!", f}
      {:draw} -> {:draw, "Game over, draw.", f}
      {:nowin} -> {:ok, f} 
    end
  end

  defp check_field(f) do
    is_map(f)
  end

  defp check_player(p) do
    p == :player_x or p == :player_o
  end

  defp check_slot(s) do
    Map.has_key?(%Field{}, s)
  end

  def check_input(field, slot, player) do
    check_field(field) and check_slot(slot) and check_player(player)
  end

  def place_stone(field, slot, player) do
    #  IO.puts("place #{player} stone in #{field} slot #{slot}")
    if check_input(field, slot, player) do
      case FieldManager.set(field, slot, player) do
        {:ok, nfield} -> check_field(nfield, player)
        {:error, msg} -> {:error, msg}
      end
    else
      IO.puts("Invalid input. Try again.")
      {:error, "Invalid input. Try again."}
    end
  end

  defp in_to_slot(input) do
    fun = &String.to_existing_atom("slot#{&1}")
    String.trim(input)
    |> String.slice(0, 1)
    |> String.to_integer()
    |> fun.()
  end

  defp toggle_player(p) do
    if p == :player_x, do: :player_o, else: :player_x
  end

  defp field_move(f, player) do
    print_field(f)
    IO.puts("\nNext: #{player}")
    input = IO.gets("Input slot to place stone: [1-9]: ")
    in_to_slot(input)
  end

  defp next_move(f, player) do
    case field_move(hd(f), player) do
      slot when is_atom(slot) -> 
        case place_stone(hd(f), slot, player) do
          {:ok, nfield} -> next_move( [nfield | f], toggle_player(player) )
          {:win, msg, nfield} -> print_field(nfield); IO.puts("#{msg}")
          {:draw, msg, nfield} -> print_field(nfield); IO.puts("#{msg}")
          {:error, msg} -> IO.puts("#{msg}"); next_move(f, player)
        end
      slot when not is_atom(slot) ->
        IO.puts("Invalid input, try again...")
        next_move(f, player)
    end
  end

  def start_game() do
    f =  [%Field{}]
    next_move(f, :player_x)
    IO.puts("= Game ends =")
  end


end
