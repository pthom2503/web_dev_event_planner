defmodule EventsWeb.UsereventController do
  use EventsWeb, :controller

  alias Events.Userevents
  alias Events.Userevents.Userevent
  
  alias EventsWeb.Plugs
  plug Plugs.RequireUser when action not in [
    :index, :show]
  plug :fetch_userevent when action in [
    :show, :photo, :edit, :update, :delete]
  plug :require_owner when action in [
    :edit, :update, :delete]  


  def fetch_userevent(conn, _args) do
    id = conn.params["id"]
    userevent = Userevents.get_userevent!(id)
    assign(conn, :userevent, userevent)
  end

  def require_owner(conn, _args) do
    # Precondition: We have these in conn
    user = conn.assigns[:current_user]
    userevent = conn.assigns[:userevent]

    if user.id == userevent.user_id do
      conn
    else
      conn
      |> put_flash(:error, "That isn't yours.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    userevent = Userevents.list_userevent()
    render(conn, "index.html", userevent: userevent)
  end

  def new(conn, _params) do
    changeset = Userevents.change_userevent(%Userevent{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"userevent" => userevent_params}) do
    userevent_params = userevent_params
    |> Map.put("user_id", conn.assigns[:current_user].id)
    case Userevents.create_userevent(userevent_params) do
      {:ok, userevent} ->
        conn
        |> put_flash(:info, "Userevent created successfully.")
        |> redirect(to: Routes.userevent_path(conn, :show, userevent))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    userevent = conn.assigns[:userevent]
    |> Userevents.load_comments()
    comm = %Events.Comments.Comment{
      userevent_id: userevent.id,
      user_id: current_user_id(conn),
      vote: "",
    }
    new_comment = Events.Comments.change_comment(comm)
    render(conn, "show.html", userevent: userevent, new_comment: new_comment)
  end

  def edit(conn, %{"id" => id}) do
    userevent = conn.assigns[:userevent]
    changeset = Userevents.change_userevent(userevent)
    render(conn, "edit.html", userevent: userevent, changeset: changeset)
  end

  def update(conn, %{"id" => id, "userevent" => userevent_params}) do
    userevent = conn.assigns[:userevent]
    case Userevents.update_userevent(userevent, userevent_params) do
      {:ok, userevent} ->
        conn
        |> put_flash(:info, "Userevent updated successfully.")
        |> redirect(to: Routes.userevent_path(conn, :show, userevent))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", userevent: userevent, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    userevent = conn.assigns[:userevent]
    {:ok, _userevent} = Userevents.delete_userevent(userevent)

    conn
    |> put_flash(:info, "Userevent deleted successfully.")
    |> redirect(to: Routes.userevent_path(conn, :index))
  end
end
