defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "New Field empty" do
    f = %Field{}
    assert Field.has_empty?(f) == true
  end

  test "Full Field empty" do
    f = %Field{
      slot1: :key_x, slot2: :key_x, slot3: :key_o,
      slot4: :key_o, slot5: :key_o, slot6: :key_x,
      slot7: :key_x, slot8: :key_x, slot9: :key_o}
    assert Field.has_empty?(f) == false
  end

  test "Partially filled Field empty" do
    f = %Field{ slot2: :key_x, slot4: :key_o, slot9: :key_o}
    assert Field.has_empty?(f) == true
  end

  test "First slot filled Field empty" do
    f = %Field{ slot1: :key_o }
    assert Field.has_empty?(f) == true
  end

  test "Last slot filled Field empty" do
    f = %Field{ slot9: :key_o }
    assert Field.has_empty?(f) == true
  end

end
