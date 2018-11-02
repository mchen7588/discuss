defmodule Discuss.CommentsChannel do
    use Discuss.Web, :channel

    def join("comments:" <> topic_id = name, _params, socket) do  # this is called when a javascript client connect to this channel
        topic_id = String.to_integer(topic_id)
        topic = Repo.get(Discuss.Topic, topic_id)

        IO.puts("*************")
        IO.puts(name)

        {:ok, %{what: "what"}, assign(socket, :topic, topic)}
    end

    def handle_in(name, %{"content" => content} = message, %{assigns: %{topic: topic}} = socket) do  # this is called when a javascript client broadcast an event to this channel
        IO.puts("#############")
        IO.inspect(message)
        IO.puts("$$$$$$$$$$$$$")
        IO.inspect(topic)

        changeset = topic
            |> build_assoc(:comment)
            |> Discuss.Comment.changeset(%{content: content})

        case Repo.insert(changeset) do
            {:ok, _} ->
                {:reply, :ok, socket}
            {:error, _} ->
                {:reply, {:error, %{error: changeset}}, socket}

        end

    end
    
end