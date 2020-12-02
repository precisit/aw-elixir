defmodule Card do
    defstruct suit: "H", rank: "2"
    def parseCard(src) do
        rank = String.at(src, 0);
        suit = String.at(src, 1);

        %Card{ suit: suit, rank: rank }
    end
end
