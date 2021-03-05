defmodule Events.UsereventsTest do
  use Events.DataCase

  alias Events.Userevents

  describe "userevent" do
    alias Events.Userevents.Userevent

    @valid_attrs %{date: ~N[2010-04-17 14:00:00], description: "some description", name: "some name"}
    @update_attrs %{date: ~N[2011-05-18 15:01:01], description: "some updated description", name: "some updated name"}
    @invalid_attrs %{date: nil, description: nil, name: nil}

    def userevent_fixture(attrs \\ %{}) do
      {:ok, userevent} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Userevents.create_userevent()

      userevent
    end

    test "list_userevent/0 returns all userevent" do
      userevent = userevent_fixture()
      assert Userevents.list_userevent() == [userevent]
    end

    test "get_userevent!/1 returns the userevent with given id" do
      userevent = userevent_fixture()
      assert Userevents.get_userevent!(userevent.id) == userevent
    end

    test "create_userevent/1 with valid data creates a userevent" do
      assert {:ok, %Userevent{} = userevent} = Userevents.create_userevent(@valid_attrs)
      assert userevent.date == ~N[2010-04-17 14:00:00]
      assert userevent.description == "some description"
      assert userevent.name == "some name"
    end

    test "create_userevent/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Userevents.create_userevent(@invalid_attrs)
    end

    test "update_userevent/2 with valid data updates the userevent" do
      userevent = userevent_fixture()
      assert {:ok, %Userevent{} = userevent} = Userevents.update_userevent(userevent, @update_attrs)
      assert userevent.date == ~N[2011-05-18 15:01:01]
      assert userevent.description == "some updated description"
      assert userevent.name == "some updated name"
    end

    test "update_userevent/2 with invalid data returns error changeset" do
      userevent = userevent_fixture()
      assert {:error, %Ecto.Changeset{}} = Userevents.update_userevent(userevent, @invalid_attrs)
      assert userevent == Userevents.get_userevent!(userevent.id)
    end

    test "delete_userevent/1 deletes the userevent" do
      userevent = userevent_fixture()
      assert {:ok, %Userevent{}} = Userevents.delete_userevent(userevent)
      assert_raise Ecto.NoResultsError, fn -> Userevents.get_userevent!(userevent.id) end
    end

    test "change_userevent/1 returns a userevent changeset" do
      userevent = userevent_fixture()
      assert %Ecto.Changeset{} = Userevents.change_userevent(userevent)
    end
  end
end
