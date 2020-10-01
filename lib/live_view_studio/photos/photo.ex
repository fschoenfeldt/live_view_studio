defmodule LiveViewStudio.Photos.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :categories, {:array, :string}
    field :date, :string
    field :description, :string
    field :title, :string
    field :url, :string
    field :user, :string

    timestamps()
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:title, :description, :url, :date, :user])
    |> validate_required([:title, :description, :url, :date, :user])
  end
end
