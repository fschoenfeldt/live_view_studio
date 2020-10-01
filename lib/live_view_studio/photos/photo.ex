defmodule LiveViewStudio.Photos.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :date, :string
    field :description, :string
    field :title, :string
    field :url, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:title, :description, :url, :date, :user])
    |> validate_required([:title, :description, :url, :date, :user])
  end
end
