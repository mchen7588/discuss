defmodule Discuss.TopicController do
    use Discuss.Web, :controller

    def new(conn, _params) do
        changeset = Discuss.Topic.changeset(%Discuss.Topic{}, %{})

        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic}) do
        changeset = Discuss.Topic.changeset(%Discuss.Topic{}, topic)

        case Repo.insert(changeset) do
            {:ok, post} -> 
                render conn, "new.html", changeset: changeset
            {:error, changeset} -> 
                render conn, "new.html", changeset: changeset
            
        end
    end
end
