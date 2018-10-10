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
            {:ok, post} -> 
                conn
                |> put_flash(:info, "topic created")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} -> 
                render conn, "new.html", changeset: changeset
            
        end
    end

    def edit(conn, _params) do
        render conn, "edit.html"
    end
end
