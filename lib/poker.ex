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

  def sort_hand(hand) do
    hand
    |> Enum.sort(fn card1,card2 -> card1.value < card2.value end)
  end

  def is_pair(hand) do
    case find_sets(hand) do
      [{_,2}] -> true
      _ -> false
    end
  end

  def is_two_pairs(hand) do
    case find_sets(hand) do
      [{_,2}, {_,2}] -> true
      _ -> false
    end
  end

  def is_three_of_kind(hand) do
    case find_sets(hand) do
      [{_,3}] -> true
      _ -> false
    end
  end

  def is_four_of_kind(hand) do
    case find_sets(hand) do
      [{_,4}] -> true
      _ -> false
    end
  end

  def is_full_house(hand) do
    case find_sets(hand) do
      [{_,3},{_,2}] -> true
      _ -> false
    end
  end

  def count_cards_of_value(hand,value) do
    hand
    |> Enum.map(fn c -> c.value end)
    |> Enum.filter(fn cval -> cval == value end)
    |> Enum.count()
  end

  def find_sets(hand) do
    2..14
    |>Enum.map(fn val -> {val, count_cards_of_value(hand, val)} end)
    |>Enum.filter(fn {_, count} -> count > 1 end)
    |>Enum.sort(fn {_, count1}, {_, count2} -> count1 > count2 end)
  end

  def is_straight(hand) do
    sorted = sort_hand(hand)

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
