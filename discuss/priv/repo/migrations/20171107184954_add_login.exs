defmodule Discuss.Repo.Migrations.AddLogin do
  use Ecto.Migration

  def change do

    create table(:login) do
      add :name, :string
      add :age, :float
      add :sex, :string
    end

  end
end
