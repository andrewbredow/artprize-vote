defmodule ArtprizeVote do
  def add_vote({user_id, entry_id}, votes) do
    votes = votes ++ [{user_id, entry_id}]
    {:ok, votes}
  end
end
