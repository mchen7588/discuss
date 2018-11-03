defmodule Discuss.Topic do
    use Discuss.Web, :model

    schema "topics" do # look inside db and find a table called topics
        field :title, :string # we expect that table to have a single column called title with type string
        belongs_to :user, Discuss.User
        has_many :comments, Discuss.Comment
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:title])
        |> validate_required([:title])
    end

end