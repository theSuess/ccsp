# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ccsp.Repo.insert!(%Ccsp.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Ccsp.Repo
alias Ccsp.User
alias Ccsp.Challenge

Repo.delete_all User
Repo.delete_all Challenge

Repo.insert! %User{
  name: "user1",
  token: "foobar"
}

Repo.insert! %User{
  name: "user2",
  token: "foobaz"
}

Repo.insert! %Challenge{
  name: "Multiply",
  content: "Multiply the input by two"
}
