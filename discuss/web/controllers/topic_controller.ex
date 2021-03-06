defmodule  Discuss.TopicController do
  use Discuss.Web, :controller
alias Discuss.Topic

plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
#atom cha coz tala ko function plug ho . mathiko chai module plug hoo...
plug :check_topic_owner when action in [:update, :edit, :delete]

def index(conn, _params) do
  topics = Repo.all(Topic)
  render conn, "index.html", topics: topics
end
  def new(conn, params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset

  end
  def create(conn, %{"topic" => topic}) do
  #  changeset = Topic.changeset(%Topic {}, topic)
  #  Repo.insert(changeset) yesko karan le hamro database ma topic 2 choti insert vako

  #conn.assigns.user le hamile current  user thanim .
  #i mean current user struct tanim. and teslai pipeline ma haldim with association to topic.user is
  #first argument to build_assoc functions, hamilai yo
  #topic sanga associate chanincha so..finally aako topic struct lai
  #..topic.changeset(topic) garim. 1st argument hai ...look 116
  changeset = conn.assigns.user
      |> build_assoc(:topics)
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end

  end
  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end
  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    changeset = Repo.get(Topic, topic_id) |> Topic.changeset(topic)
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)
    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "topic updated")
        |> redirect(to: topic_path(conn, :index))
        {:error, changeset} ->
          render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end
  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic deleted")
    |> redirect(to: topic_path(conn, :index))
  end
  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: topic_path(conn, :index))
      |> halt()


end
end
end
