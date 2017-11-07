defmodule Discuss.Login  do
  use Discuss.Web, :model
  schema "login" do
    field :name, :string
    field :age, :float
    field :sex, :string



  end
  def changeset(struct, params \\ %{}) do
    struct
      |> cast(params, [:name, :age, :sex])
      |> validate_required([:name, :age, :sex])

  end

end
