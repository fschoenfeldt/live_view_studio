defmodule LiveViewStudio.Repo.Migrations.AddCategoriesColumn do
  use Ecto.Migration

  def change do
    alter table("photos") do
      add :categories, {:array, :string}
    end
  end
end
