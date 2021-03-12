defmodule Events.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :vote, :integer
      add :userevent_id, references(:userevent, on_delete: :nothing)
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:userevent_id])
    create index(:comments, [:user_id])
  end
end
