defmodule Card do
  defstruct suit: "H", rank: "2", value: 0

  def parseCard(src) do
    rank = String.at(src, 0)
    suit = String.at(src, 1)

    value = case Integer.parse(rank) do
      :error ->
        case rank do
          "T" -> 10
          "J" -> 11
          "Q" -> 12
          "K" -> 13
          "A" -> 14
        end
      {n, _} ->
        n
    end

    %Card{suit: suit, rank: rank, value: value}
  end
end
