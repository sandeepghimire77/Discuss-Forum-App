defmodule  Discuss.LoginController do
  use Discuss.Web, :controller
  alias Discuss.Login

  def indexes(conn, _params) do
    login = Repo.all(Login)
    render conn, "indexes.html", login: login
  end

  def new(conn, _params) do
      changeset = Login.changeset(%Login{}, %{})
    render conn, "new.html", changeset: changeset
  end
  def create(conn, %{"login" => login}) do
    changeset = Login.changeset(%Login {}, login)
    Repo.insert(changeset)

    case Repo.insert(changeset) do
      {:ok, post } ->
        conn
        |> put_flash(:info, "Login created")
        |> redirect(to: login_path(conn, :indexes))

      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end

  end
end
