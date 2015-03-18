defmodule ArtprizeVoteTest do
  use ExUnit.Case
  doctest ArtprizeVote

  test "calculates the correct winner" do
    votes = [{1, 2}, {1, 3}, {2, 2}, {3, 2}, {4, 2}]
    assert ArtprizeVote.calculate_winner(votes) == {2, 4}
  end
end
