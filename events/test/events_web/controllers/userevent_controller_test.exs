defmodule EventsWeb.UsereventControllerTest do
  use EventsWeb.ConnCase

  alias Events.Userevents

  @create_attrs %{date: ~N[2010-04-17 14:00:00], description: "some description", name: "some name"}
  @update_attrs %{date: ~N[2011-05-18 15:01:01], description: "some updated description", name: "some updated name"}
  @invalid_attrs %{date: nil, description: nil, name: nil}

  def fixture(:userevent) do
    {:ok, userevent} = Userevents.create_userevent(@create_attrs)
    userevent
  end

  describe "index" do
    test "lists all userevent", %{conn: conn} do
      conn = get(conn, Routes.userevent_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Userevent"
    end
  end

  describe "new userevent" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.userevent_path(conn, :new))
      assert html_response(conn, 200) =~ "New Userevent"
    end
  end

  describe "create userevent" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.userevent_path(conn, :create), userevent: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.userevent_path(conn, :show, id)

      conn = get(conn, Routes.userevent_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Userevent"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.userevent_path(conn, :create), userevent: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Userevent"
    end
  end

  describe "edit userevent" do
    setup [:create_userevent]

    test "renders form for editing chosen userevent", %{conn: conn, userevent: userevent} do
      conn = get(conn, Routes.userevent_path(conn, :edit, userevent))
      assert html_response(conn, 200) =~ "Edit Userevent"
    end
  end

  describe "update userevent" do
    setup [:create_userevent]

    test "redirects when data is valid", %{conn: conn, userevent: userevent} do
      conn = put(conn, Routes.userevent_path(conn, :update, userevent), userevent: @update_attrs)
      assert redirected_to(conn) == Routes.userevent_path(conn, :show, userevent)

      conn = get(conn, Routes.userevent_path(conn, :show, userevent))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, userevent: userevent} do
      conn = put(conn, Routes.userevent_path(conn, :update, userevent), userevent: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Userevent"
    end
  end

  describe "delete userevent" do
    setup [:create_userevent]

    test "deletes chosen userevent", %{conn: conn, userevent: userevent} do
      conn = delete(conn, Routes.userevent_path(conn, :delete, userevent))
      assert redirected_to(conn) == Routes.userevent_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.userevent_path(conn, :show, userevent))
      end
    end
  end

  defp create_userevent(_) do
    userevent = fixture(:userevent)
    %{userevent: userevent}
  end
end
