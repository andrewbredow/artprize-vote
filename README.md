# Artprize Voting App

## Demo for GRDevDay 2015

See the accompanying slides [here](https://speakerdeck.com/andrewbredow/mix-it-up-with-elixir).

Step through the commits to follow the project as we derive a multi process voting server
from a simple function with an accumulator to hold votes.

When you're through with this, you may be interested in checking out the more full-featured
Phoenix [version](https://github.com/andrewbredow/artprize-vote-phoenix) of this application.
It utilizes GenServer to run the actual Vote server under the app's supervision.

To start the console to play with the demo:

1. Navigate to the project directory
2. Run `iex -S mix`
3. Start the server process with: `{:ok, pid} = ArtprizeVote.start_server`
4. Send your votes to the server process: `send pid, {self, :add_vote, {16, 69, {-85.6, 43}}}`, etc...
5. Check the messages the server sends back to the main process by running `flush`
