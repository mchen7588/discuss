defmodule Discuss.CommentsChannel do
    use Discuss.Web, :channel
    alias Discuss.{ Topic, Comment }

    def join("comments:" <> topic_id, _params, socket) do  # this is called when a javascript client connect to this channel
        topic_id = String.to_integer(topic_id)
        topic = Topic
            |> Repo.get(topic_id)
            |> Repo.preload(comments: [:user])

        {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
    end

    def handle_in(_name, %{"content" => content}, %{assigns: %{topic: topic, user_id: user_id}} = socket) do  # this is called when a javascript client broadcast an event to this channel
        changeset = topic
            |> build_assoc(:comments, user_id: user_id)
            |> Comment.changeset(%{content: content})

        case Repo.insert(changeset) do
            {:ok, comment} ->
                broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
                {:reply, :ok, socket}
            {:error, _} ->
                {:reply, {:error, %{error: changeset}}, socket}
        end
    end
end