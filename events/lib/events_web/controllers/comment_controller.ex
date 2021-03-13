defmodule EventsWeb.CommentController do
  use EventsWeb, :controller

  alias Events.Comments
  alias Events.Comments.Comment
  alias Events.Photos

  def index(conn, _params) do
    comments = Comments.list_comments()
    render(conn, "index.html", comments: comments)
  end

  def new(conn, _params) do
    changeset = Comments.change_comment(%Comment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"email" => email, "userevent"=> userevent_id}) do
    user = if Events.Users.get_email(email) != nil do
      Events.Users.get_email(email)
    else
      photo_path = Path.join(Application.app_dir(:events, "priv/photos"), "succulent.jpg")
      {:ok, photo_hash} = Photos.save_photo("succelent.jpg", photo_path)
      user_params = %{name: "unregistered_user", email: email, photo_hash: photo_hash}
      {:ok, user} = Events.Users.create_user(user_params)
      user
    end
    comment_params = %{user_id: user.id, userevent_id: userevent_id, body: "No Comment", vote: "Has not responded"}

    case Comments.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Invite Link: http://events/dialnerd.me/events/{userevent_id}")
        |> redirect(to: Routes.userevent_path(conn, :show, userevent_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def create(conn, %{"comment" => comment_params}) do
    comment_params = comment_params
    |> Map.put("user_id", current_user_id(conn))
    case Comments.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.userevent_path(conn, :show, comment.userevent_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    changeset = Comments.change_comment(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Comments.get_comment!(id)

    case Comments.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes.userevent_path(conn, :show, comment.userevent_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    {:ok, _comment} = Comments.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.userevent_path(conn, :index))
  end
end
