defmodule Events.Repo.Migrations.CreateUserevent do
  use Ecto.Migration

  def change do
    create table(:userevent) do
      add :name, :string, null: false
      add :date, :naive_datetime
      add :description, :text, null: false
      add :user_id, references(:user), null: false

      timestamps()
    end

  end
end
