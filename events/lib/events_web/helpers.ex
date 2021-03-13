# taken from lecture notes
defmodule EventsWeb.Helpers do
  alias Events.Users.User

  def current_user_id(conn) do
    user = conn.assigns[:current_user]
    user && user.id
  end

  def is_invited?(conn, userevent_id, user_id) do
    if current_user_is?(conn, user_id) do
      true
    else
      if not have_current_user?(conn) do
        false
      else
        user = conn.assigns[:current_user]
        Events.Comments.invited(user.id, userevent_id)
      end
    end
  end

  def have_current_user?(conn) do
    conn.assigns[:current_user] != nil
  end

  def current_user_is?(conn, %User{} = user) do
    current_user_is?(conn, user.id)
  end

  def current_user_is?(conn, user_id) do
    current_user_id(conn) == user_id
  end
end

