defmodule ArtprizeVote do
  def start_server do
    Task.start_link(fn -> listen([]) end)
  end

  def listen(votes) do
    receive do
      {sender, :add_vote, {user_id, entry_id, coordinates}} ->
        result = add_vote(user_id, entry_id, coordinates, votes)
        {_, _, votes} = result
        send sender, result
        listen(votes)
      {sender, :get_votes} ->
        send sender, {:ok, votes}
        listen(votes)
      {sender, _} ->
        send sender, {:wtf}
        listen(votes)
    end
  end

  # -85.726469,42.906554,-85.55457,43.01148
  defp add_vote(_, _, {lat, lng}, votes)
  when not lat in -85.726469..-85.55457 or not lng in 42.906554..43.01148 do
    {:err, "You must be in Grand Rapids to vote.", votes}
  end

  defp add_vote(user_id, entry_id, _, votes)
  when is_integer(user_id) and is_integer(entry_id) do
    votes = votes ++ [{user_id, entry_id}]
    {:ok, "Successfully voted for entry, #{entry_id}.", votes}
  end
end
