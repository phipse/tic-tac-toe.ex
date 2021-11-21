defmodule Field do
  defstruct [:slot1, :slot2, :slot3, 
             :slot4, :slot5, :slot6,
             :slot7, :slot8, :slot9]

  def get(field, key) do
    case key do
      :slot1 -> field.slot1
      :slot2 -> field.slot2
      :slot3 -> field.slot3
      :slot4 -> field.slot4
      :slot5 -> field.slot5
      :slot6 -> field.slot6
      :slot7 -> field.slot7
      :slot8 -> field.slot8
      :slot9 -> field.slot9
    end
  end

  defp empty?(head, tail, res) do
    r = head == nil or res
    case tail do
      [] ->  r
      _ -> empty?(hd(tail), tl(tail), r)
    end
  end
    
  def has_empty?(field) do
    vals = Map.values(field)
    empty?(hd(vals), tl(vals), false)
  end
    

  def print(field) do
    #    IO.puts("#{inspect(field)}")
    IO.puts("| --- | --- | --- |")
    IO.puts("| #{inspect(field.slot1)} | #{inspect(field.slot2)} | #{inspect(field.slot3)} |")
    IO.puts("| #{inspect(field.slot4)} | #{inspect(field.slot5)} | #{inspect(field.slot6)} |")
    IO.puts("| #{inspect(field.slot7)} | #{inspect(field.slot8)} | #{inspect(field.slot9)} |")
    IO.puts("| --- | --- | --- |")
  end

end
