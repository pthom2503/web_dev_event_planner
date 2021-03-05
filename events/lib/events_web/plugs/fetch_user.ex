# taken from lecture code
defmodule EventsWeb.Plugs.FetchUser do
  import Plug.Conn

  def init(args), do: args

  def call(conn, _args) do
    user_id = get_session(conn, :user_id) || -1
    user = Event.Users.get_user(user_id)
    if user do
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

  # conn.assigns[:current_user]
  # <%= @current_user.name %>
end

