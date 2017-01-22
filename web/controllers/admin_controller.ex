defmodule Ccsp.AdminController do
  use Ccsp.Web, :controller

  defmodule Entry do
    defstruct [:name,:sum]
  end

  def leaderboard(conn, _params) do
    qry = "SELECT users.name,sum(DISTINCT number) FROM submissions JOIN challenges ON challenge_id=challenges.id JOIN users ON user_id=users.id GROUP BY user_id,users.name ORDER BY sum DESC"
    res = Ecto.Adapters.SQL.query!(Repo, qry, [])
    cols = Enum.map res.columns, &(String.to_atom(&1))
    entries = Enum.map res.rows, fn(row) ->
      struct(Entry, Enum.zip(cols, row))
    end
    render(conn, "leaderboard.html", board: entries)
  end
end
