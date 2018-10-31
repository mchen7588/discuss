defmodule Discuss.CommentsChannel do
    use Discuss.Web, :channel

    def join("comments:" <> topic_id = name, _params, socket) do  # this is called when a javascript client connect to this channel
        topic_id = String.to_integer(topic_id)
        Repo.get(Discuss.Topic, topic_id)

        IO.puts("*************")
        IO.puts(name)

        {:ok, %{what: "what"}, socket}
    end

    def handle_in(name, message, socket) do  # this is called when a javascript client broadcast an event to this channel
        IO.puts("#############")
        IO.inspect(message)

        {:reply, :ok, socket}
    end
    
end