defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Retuns a list of strings representing a deck of playing cards

  ## Examples

      iex> deck = Cards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Six of Spades", "Seven of Spades", "Eight of Spades",
      "Nine of Spades", "Prince of Spades", "Queen of Spades", "King of Spades",
      "Ace of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs",
      "Five of Clubs", "Six of Clubs", "Seven of Clubs", "Eight of Clubs",
      "Nine of Clubs", "Prince of Clubs", "Queen of Clubs", "King of Clubs",
      "Ace of Hearts", "Two of Hearts", "Three of Hearts", "Four of Hearts",
      "Five of Hearts", "Six of Hearts", "Seven of Hearts", "Eight of Hearts",
      "Nine of Hearts", "Prince of Hearts", "Queen of Hearts", "King of Hearts",
      "Ace of Diamonds", "Two of Diamonds", "Three of Diamonds",
      "Four of Diamonds", "Five of Diamonds", "Six of Diamonds",
      "Seven of Diamonds", "Eight of Diamonds", "Nine of Diamonds",
      "Prince of Diamonds", "Queen of Diamonds", "King of Diamonds"]


  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Prince", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
        "#{value} of #{suit}"
    end

  end
  @doc """
    Returns a list of strings create before, shuffled.
    The `deck` argument refers to the list to be shuffled.
  ## Examples

      iex> deck = Cards.create_deck
      iex> deck = Cards.shuffle(deck)
      ["Prince of Clubs", "Nine of Hearts", "Eight of Spades", "Four of Diamonds",
      "Five of Diamonds", "Ace of Hearts", "Prince of Diamonds", "Four of Clubs",
      "Prince of Spades", "Four of Spades", "Five of Spades", "King of Spades",
      "Queen of Diamonds", "Two of Spades", "King of Hearts", "Six of Spades",
      "Seven of Hearts", "Five of Clubs", "Two of Clubs", "Four of Hearts",
      "Ace of Spades", "Three of Hearts", "Eight of Clubs", "Eight of Hearts",
      "Six of Clubs", "Prince of Hearts", "Two of Hearts", "Nine of Clubs",
      "Three of Clubs", "Seven of Clubs", "King of Diamonds",
      "Seven of Diamonds", "Ace of Diamonds", "Queen of Spades",
      "Queen of Hearts", "Five of Hearts", "Six of Diamonds", "Seven of Spades",
      "Two of Diamonds", "Nine of Diamonds", "Six of Hearts", "Nine of Spades",
      "Queen of Clubs", "Three of Spades", "Three of Diamonds", "King of Clubs",
      "Eight of Diamonds", "Ace of Clubs"]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Checks if a card exist in the deck
    The first argument is the deck to analyze, the second, the card to find, in string format

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Queen of Rubies")
      false
      iex> Cards.contains?(deck, "Queen of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.
  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Save the deck given as binary archive under filename

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.save(deck, "my_deck")
      :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Load the deck given as binary archive under filename, and returns it

  ## Examples

      iex> Cards.load("my_deck")
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Six of Spades", "Seven of Spades", "Eight of Spades",
      "Nine of Spades", "Prince of Spades", "Queen of Spades", "King of Spades",
      "Ace of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs",
      "Five of Clubs", "Six of Clubs", "Seven of Clubs", "Eight of Clubs",
      "Nine of Clubs", "Prince of Clubs", "Queen of Clubs", "King of Clubs",
      "Ace of Hearts", "Two of Hearts", "Three of Hearts", "Four of Hearts",
      "Five of Hearts", "Six of Hearts", "Seven of Hearts", "Eight of Hearts",
      "Nine of Hearts", "Prince of Hearts", "Queen of Hearts", "King of Hearts",
      "Ace of Diamonds", "Two of Diamonds", "Three of Diamonds",
      "Four of Diamonds", "Five of Diamonds", "Six of Diamonds",
      "Seven of Diamonds", "Eight of Diamonds", "Nine of Diamonds",
      "Prince of Diamonds", "Queen of Diamonds", "King of Diamonds"]

  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
  Create a deck, shuffle it, and then deals it.
  `hand_size` refers to the size of the hand deals

  ## Examples

      iex> deck = Cards.create_hand(5)
      {["Two of Clubs", "Six of Spades", "Six of Diamonds", "Prince of Diamonds",
      "Prince of Clubs"],
      ["Two of Hearts", "Two of Diamonds", "Queen of Hearts", "King of Spades",
      "Four of Spades", "Ace of Spades", "Seven of Diamonds", "Five of Spades",
      "Five of Diamonds", "Six of Clubs", "Four of Clubs", "Ace of Clubs",
      "King of Clubs", "Nine of Clubs", "Two of Spades", "Nine of Diamonds",
      "Nine of Hearts", "Nine of Spades", "King of Hearts", "Eight of Hearts",
      "Eight of Spades", "Four of Hearts", "Ace of Diamonds",
      "Prince of Spades", "Three of Diamonds", "Three of Hearts",
      "Seven of Spades", "Ace of Hearts", "Queen of Clubs", "Three of Clubs",
      "Five of Hearts", "Seven of Clubs", "Queen of Spades", "King of Diamonds",
      "Six of Hearts", "Eight of Diamonds", "Queen of Diamonds",
      "Eight of Clubs", "Five of Clubs", "Seven of Hearts", "Prince of Hearts",
      "Three of Spades", "Four of Diamonds"]}

  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
