defmodule CardsTest do
  use ExUnit.Case
  test "create_deck makes a complete deck of 48 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 48
  end

  test "Shuffling a deck randomizes it" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
  end
end
