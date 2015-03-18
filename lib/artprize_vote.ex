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
      {sender, :get_winner} ->
        send sender, {:ok, calculate_winner(votes)}
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

  def calculate_winner(votes) do
    votes
    |> unique_by_voter_and_entry
    |> sum_per_entry(%{})
    |> order_by_votes
    |> Enum.at(0, %{})
  end

  def unique_by_voter_and_entry(votes), do: Enum.uniq votes

  def sum_per_entry([], sums), do: sums
  def sum_per_entry([{_, entry_id}|tail], sums) do
    initial_value = Dict.get(sums, entry_id, 0)
    sums = Dict.put(sums, entry_id, initial_value + 1)
    sum_per_entry(tail, sums)
  end

  @doc """
  Takes a list of {entry_id, entry_vote_count} tuples and orders them
  in descending order by votes

  # Example

    iex> ArtprizeVote.order_by_votes([{2, 34}, {1, 50}, {3, 2}])
    [{1, 50}, {2, 34}, {3, 2}]

  """
  def order_by_votes(sums) do
    Enum.sort(sums, fn {_, sum_1}, {_, sum_2} -> sum_1 > sum_2 end)
  end
end
