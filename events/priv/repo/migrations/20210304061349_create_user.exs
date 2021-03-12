defmodule Events.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :photo_hash, :text, null: false

      timestamps()
    end

  end
end
