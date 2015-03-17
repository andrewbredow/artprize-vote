defmodule ArtprizeVote do
  def add_vote({user_id, entry_id}, votes) when is_integer(user_id) and is_integer(entry_id) do
    votes = votes ++ [{user_id, entry_id}]
    {:ok, votes}
  end
end
