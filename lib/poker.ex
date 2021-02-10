defmodule Poker do
  def main() do
    parser()
    |> to_cards()
    |> to_hands()
  end

  def to_hands(all_hands) do
    all_hands
    |> Enum.map(fn game -> { Enum.take(game, 5), Enum.drop(game, 5)} end)
  end

  def parser() do
    "../assets/p054_poker.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
    |> Enum.map(fn x -> String.split(x, ~r/\s/) end)
  end

  def to_cards(poker_games) do
    poker_games
    |> Enum.map(fn game -> Enum.map(game, &Card.parseCard/1) end)
  end

  def compare_hands({hand1, hand2}) do
    # High Card: Highest value card.
    # One Pair: Two cards of the same value.
    # Two Pairs: Two different pairs.
    # Three of a Kind: Three cards of the same value.
    # Straight: All cards are consecutive values.
    # Flush: All cards of the same suit.
    # Full House: Three of a kind and a pair.
    # Four of a Kind: Four cards of the same value.
    # Straight Flush: All cards are consecutive values of same suit.
    # Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
  end

  def is_straight(hand) do
    sorted = hand
    |> Enum.sort(fn card1,card2 -> card1.value < card2.value end)

    sorted
    |> Enum.zip(Enum.drop(sorted,1))
    |> Enum.all?(fn {c1, c2} -> c2.value-c1.value == 1 end)
  end

  def is_flush(hand) do
    [first | _ ] = hand

    hand
    |> Enum.all?(fn card -> card.suit == first.suit end)
  end

  def is_straight_flush(hand), do: is_straight(hand) and is_flush(hand)
end
