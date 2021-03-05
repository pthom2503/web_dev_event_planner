defmodule EventsWeb.UsereventController do
  use EventsWeb, :controller

  alias Events.Userevents
  alias Events.Userevents.Userevent

  def index(conn, _params) do
    userevent = Userevents.list_userevent()
    render(conn, "index.html", userevent: userevent)
  end

  def new(conn, _params) do
    changeset = Userevents.change_userevent(%Userevent{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"userevent" => userevent_params}) do
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
    userevent = Userevents.get_userevent!(id)
    render(conn, "show.html", userevent: userevent)
  end

  def edit(conn, %{"id" => id}) do
    userevent = Userevents.get_userevent!(id)
    changeset = Userevents.change_userevent(userevent)
    render(conn, "edit.html", userevent: userevent, changeset: changeset)
  end

  def update(conn, %{"id" => id, "userevent" => userevent_params}) do
    userevent = Userevents.get_userevent!(id)

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
    userevent = Userevents.get_userevent!(id)
    {:ok, _userevent} = Userevents.delete_userevent(userevent)

    conn
    |> put_flash(:info, "Userevent deleted successfully.")
    |> redirect(to: Routes.userevent_path(conn, :index))
  end
end
