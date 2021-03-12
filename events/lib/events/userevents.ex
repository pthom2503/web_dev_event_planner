defmodule Events.Userevents do
  @moduledoc """
  The Userevents context.
  """

  import Ecto.Query, warn: false
  alias Events.Repo

  alias Events.Userevents.Userevent

  @doc """
  Returns the list of userevent.

  ## Examples

      iex> list_userevent()
      [%Userevent{}, ...]

  """
  def list_userevent do
    Repo.all(Userevent)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single userevent.

  Raises `Ecto.NoResultsError` if the Userevent does not exist.

  ## Examples

      iex> get_userevent!(123)
      %Userevent{}

      iex> get_userevent!(456)
      ** (Ecto.NoResultsError)

  """
  def get_userevent!(id) do
    Repo.get!(Userevent, id)
    |> Repo.preload(:user)
  end

  def load_comments(%Userevent{} = userevent) do
    Repo.preload(userevent, [comments: :user])
  end

  @doc """
  Creates a userevent.

  ## Examples

      iex> create_userevent(%{field: value})
      {:ok, %Userevent{}}

      iex> create_userevent(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_userevent(attrs \\ %{}) do
    %Userevent{}
    |> Userevent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a userevent.

  ## Examples

      iex> update_userevent(userevent, %{field: new_value})
      {:ok, %Userevent{}}

      iex> update_userevent(userevent, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_userevent(%Userevent{} = userevent, attrs) do
    userevent
    |> Userevent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a userevent.

  ## Examples

      iex> delete_userevent(userevent)
      {:ok, %Userevent{}}

      iex> delete_userevent(userevent)
      {:error, %Ecto.Changeset{}}

  """
  def delete_userevent(%Userevent{} = userevent) do
    Repo.delete(userevent)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking userevent changes.

  ## Examples

      iex> change_userevent(userevent)
      %Ecto.Changeset{data: %Userevent{}}

  """
  def change_userevent(%Userevent{} = userevent, attrs \\ %{}) do
    Userevent.changeset(userevent, attrs)
  end
end
