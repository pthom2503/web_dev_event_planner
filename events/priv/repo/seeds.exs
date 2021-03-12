# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Events.Repo.insert!(%Events.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
alias Events.Repo
alias Events.Users.User
alias Events.Userevents.Userevent
alias Events.Photos

defmodule Inject do
  def photo(name) do
    photos = Application.app_dir(:events, "priv/photos")
    path = Path.join(photos, name)
    {:ok, hash} = Photos.save_photo(name, path)
    hash
  end
end


palm = Inject.photo("palm_tree.jpg")
flower = Inject.photo("flower_tree.jpg")


alice = Repo.insert!(%User{name: "alice", email: "alice@gmail.com", photo_hash: flower})
bob = Repo.insert!(%User{name: "bob", email: "bob123@gmail.com", photo_hash: palm})

#Repo.insert(%Userevent{user_id: alice.id, name: "Test event", date: null, description: "test event to verify attachment of event owners"})
