defmodule  Discuss.LoginController do
  use Discuss.Web, :controller
  alias Discuss.Login
  def index(conn, _params) do
    login = Repo.all(Login)
    render conn, "index.html", login: login
  end

  def new(conn, _params) do
      changeset = Login.changeset(%Login{}, %{})
    render conn, "new.html", changeset: changeset
  end
  def create(conn, %{"login" => login}) do
    changeset = Login.changeset(%Login {}, login)
    Repo.insert(changeset)

    case Repo.insert(changeset) do
      {:ok, post } -> IO.inspect(post)
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end

  end
end





defmodule  Discuss.TopicController do
  use Discuss.Web, :controller
alias Discuss.Topic

def index(conn, _params) do
  topics = Repo.all(Topic)
  render conn, "index.html", topics: topics
end
  def new(conn, params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset

  end
  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic {}, topic)
    Repo.insert(changeset)

    case Repo.insert(changeset) do
      {:ok, post } -> IO.inspect(post)
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end

  end


end
