defmodule ArtprizeVote do
  # -85.726469,42.906554,-85.55457,43.01148
  def add_vote(_, _, {lat, lng}, _)
    when not lat in -85.726469..-85.55457 or not lng in 42.906554..43.01148 do
      {:err, "You must be in Grand Rapids to vote."}
  end

  def add_vote(user_id, entry_id, _, votes) when is_integer(user_id) and is_integer(entry_id) do
    votes = votes ++ [{user_id, entry_id}]
    {:ok, votes}
  end
end
