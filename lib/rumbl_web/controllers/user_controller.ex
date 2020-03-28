defmodule RumblWeb.UserController do
  use RumblWeb, :controller
  alias Rumbl.Repo
  alias Rumbl.User

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} successfully created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  def index(conn, _params) do
    users = Repo.all(Rumbl.User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Rumbl.User, id)
    render(conn, "show.html", user: user)
  end
end
