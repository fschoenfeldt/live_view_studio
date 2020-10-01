defmodule LiveViewStudio.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :title, :string
      add :description, :text
      add :url, :string
      add :date, :string
      add :user, :string

      timestamps()
    end

  end
end
