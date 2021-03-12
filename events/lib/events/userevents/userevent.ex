defmodule Events.Userevents.Userevent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "userevent" do
    field :date, :naive_datetime
    field :description, :string
    field :name, :string
    belongs_to :user, Events.Users.User
    has_many :comments, Events.Comments.Comment
    timestamps()
  end

  @doc false
  def changeset(userevent, attrs) do
    userevent
    |> cast(attrs, [:name, :date, :description, :user_id])
    |> validate_required([:name, :date, :description, :user_id])
  end
end
