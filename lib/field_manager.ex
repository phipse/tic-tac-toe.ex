defmodule FieldManager do

  def set(field, num, player) do
    #IO.puts("#{inspect(field)} num #{num} player #{player}")
    case player do
      :player_x -> set_x(field, num) 
      :player_o -> set_o(field, num)
    end
  end

  defp set_x(field, num) do
    #IO.puts("set_x: #{inspect(field)}, #{num}")
    #IO.puts("get: #{Field.get(field, num)}")
    if Field.get(field, num) == nil do
      {:ok, %{field | num => :key_x}}
    else
      {:error, "Slot #{num} already taken: #{Field.get(field, num)}."}
    end
  end

  defp set_o(field, num) do
    if Field.get(field, num) == nil do
      {:ok, %{field | num => :key_o}}
    else
      {:error, "Slot already taken."}
    end
  end

  def print_field(field) do
    field |> Field.print
  end

  defp get_key(player) do
    case player do
      :player_x -> :key_x
      :player_o -> :key_o
    end
  end

  defp check_rows(f, key) do
    Field.get(f, :slot1) == key
      and Field.get(f, :slot2) == key
      and Field.get(f, :slot3) == key
    or 
    Field.get(f, :slot4) == key
      and Field.get(f, :slot5) == key
      and Field.get(f, :slot6) == key
    or 
    Field.get(f, :slot7) == key
      and Field.get(f, :slot8) == key
      and Field.get(f, :slot9) == key
  end

  defp check_columns(f, key) do
    Field.get(f, :slot1) == key
    and Field.get(f, :slot4) == key
    and Field.get(f, :slot7) == key
    or
    Field.get(f, :slot2) == key
    and Field.get(f, :slot5) == key
    and Field.get(f, :slot8) == key
    or
    Field.get(f, :slot3) == key
    and Field.get(f, :slot6) == key
    and Field.get(f, :slot9) == key
  end

  defp check_diags(f, key) do
    if (Field.get(f, :slot5)) do
      Field.get(f, :slot1) == key
        and Field.get(f, :slot5) == key
        and Field.get(f, :slot9) == key
        or
      Field.get(f, :slot3) == key
        and Field.get(f, :slot5) == key
        and Field.get(f, :slot7) == key
    else
      false
    end
  end

  defp slots_left?(field) do
    Field.has_empty?(field)
  end

  def check_win(field, player) do
    key = get_key(player)    
    player_wins = check_rows(field, key) or check_columns(field, key) or
      check_diags(field, key)

      #    if player_wins do
      #      IO.puts("#{player} wins")
      #    else
      #      IO.puts("next move")
      #    end

    case player_wins do
      true -> {:win}
      false ->  if slots_left?(field) == false, do: {:draw}, else: {:nowin}
    end

  end
end
