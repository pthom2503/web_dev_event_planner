defmodule Events.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :name, :string
    field :email, :string
    field :photo_hash, :string
    has_many :userevents, Events.Userevents.Userevent
    has_many :comments, Events.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :photo_hash])
    |> validate_required([:name, :email, :photo_hash])
  end
end
