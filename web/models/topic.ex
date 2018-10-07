defmodule Discuss.Topic do
    use Discuss.Web, :model

    schema "topics" do # look inside db and find a table called topics
        field :title, :string # we expect that table to have a single column called title with type string
    end
end