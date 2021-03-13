defmodule Events.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text, null: false
      add :vote, :string, null: false, default: ""
      add :userevent_id, references(:userevent, on_delete: :nothing)
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:userevent_id, :user_id], unique: true)
    create index(:comments, [:userevent_id])
    create index(:comments, [:user_id])
  end
end
