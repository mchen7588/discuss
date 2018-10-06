defmodule Discuss.Repo.Migrations.AddTopic do
  use Ecto.Migration

  def change do
    create table(:topics) do  # create a new table called topics
      add :title, :string  # within the topics table, add a column called title with a type string
    end
  end
end
