defmodule Discuss.TopicController do
    use Discuss.Web, :controller

    def index(conn, _params) do
        topics = Repo.all(Discuss.Topic)

        render conn, "index.html", topics: topics
    end

    def new(conn, _params) do
        changeset = Discuss.Topic.changeset(%Discuss.Topic{}, %{})

        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic}) do
        changeset = Discuss.Topic.changeset(%Discuss.Topic{}, topic)

        case Repo.insert(changeset) do
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "topic created")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} -> 
                render conn, "new.html", changeset: changeset
        end
    end

    def edit(conn, %{"id" => id}) do
        topic = Repo.get(Discuss.Topic, id)
        changeset = Discuss.Topic.changeset(topic)

        render conn, "edit.html", changeset: changeset, topic: topic
    end

    def update(conn, %{"id" => id, "topic" => new_topic}) do
        old_topic = Repo.get(Discuss.Topic, id)
        changeset = Discuss.Topic.changeset(old_topic, new_topic)

        case Repo.update(changeset) do
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "topic updated")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                render conn, "edit.html", changeset: changeset, topic: old_topic
        end
    end

    def delete(conn, %{"id" => id}) do
        Repo.get!(Discuss.Topic, id) |> Repo.delete!

        conn
        |> put_flash(:info, "topic deleted")
        |> redirect(to: topic_path(conn, :index))
    end
end
