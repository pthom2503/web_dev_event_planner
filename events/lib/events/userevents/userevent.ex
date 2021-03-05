defmodule Events.Userevents.Userevent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "userevent" do
    field :date, :naive_datetime
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(userevent, attrs) do
    userevent
    |> cast(attrs, [:name, :date, :description])
    |> validate_required([:name, :date, :description])
  end
end
