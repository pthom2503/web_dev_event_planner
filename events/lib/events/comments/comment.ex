defmodule Events.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    field :vote, :string
    belongs_to :userevent, Events.Userevents.Userevent
    belongs_to :user, Events.Users.User   

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :vote, :userevent_id, :user_id])
    |> validate_required([:body, :vote, :userevent_id, :user_id])
  end
end
