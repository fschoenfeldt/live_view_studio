defmodule LiveViewStudio.PhotosTest do
  use LiveViewStudio.DataCase

  alias LiveViewStudio.Photos

  describe "photos" do
    alias LiveViewStudio.Photos.Photo

    @valid_attrs %{date: "some date", description: "some description", title: "some title", url: "some url"}
    @update_attrs %{date: "some updated date", description: "some updated description", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{date: nil, description: nil, title: nil, url: nil}

    def photo_fixture(attrs \\ %{}) do
      {:ok, photo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Photos.create_photo()

      photo
    end

    test "list_photos/0 returns all photos" do
      photo = photo_fixture()
      assert Photos.list_photos() == [photo]
    end

    test "get_photo!/1 returns the photo with given id" do
      photo = photo_fixture()
      assert Photos.get_photo!(photo.id) == photo
    end

    test "create_photo/1 with valid data creates a photo" do
      assert {:ok, %Photo{} = photo} = Photos.create_photo(@valid_attrs)
      assert photo.date == "some date"
      assert photo.description == "some description"
      assert photo.title == "some title"
      assert photo.url == "some url"
    end

    test "create_photo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Photos.create_photo(@invalid_attrs)
    end

    test "update_photo/2 with valid data updates the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{} = photo} = Photos.update_photo(photo, @update_attrs)
      assert photo.date == "some updated date"
      assert photo.description == "some updated description"
      assert photo.title == "some updated title"
      assert photo.url == "some updated url"
    end

    test "update_photo/2 with invalid data returns error changeset" do
      photo = photo_fixture()
      assert {:error, %Ecto.Changeset{}} = Photos.update_photo(photo, @invalid_attrs)
      assert photo == Photos.get_photo!(photo.id)
    end

    test "delete_photo/1 deletes the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{}} = Photos.delete_photo(photo)
      assert_raise Ecto.NoResultsError, fn -> Photos.get_photo!(photo.id) end
    end

    test "change_photo/1 returns a photo changeset" do
      photo = photo_fixture()
      assert %Ecto.Changeset{} = Photos.change_photo(photo)
    end
  end

  describe "photos" do
    alias LiveViewStudio.Photos.Photo

    @valid_attrs %{date: "some date", description: "some description", title: "some title", url: "some url", user: "some user"}
    @update_attrs %{date: "some updated date", description: "some updated description", title: "some updated title", url: "some updated url", user: "some updated user"}
    @invalid_attrs %{date: nil, description: nil, title: nil, url: nil, user: nil}

    def photo_fixture(attrs \\ %{}) do
      {:ok, photo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Photos.create_photo()

      photo
    end

    test "list_photos/0 returns all photos" do
      photo = photo_fixture()
      assert Photos.list_photos() == [photo]
    end

    test "get_photo!/1 returns the photo with given id" do
      photo = photo_fixture()
      assert Photos.get_photo!(photo.id) == photo
    end

    test "create_photo/1 with valid data creates a photo" do
      assert {:ok, %Photo{} = photo} = Photos.create_photo(@valid_attrs)
      assert photo.date == "some date"
      assert photo.description == "some description"
      assert photo.title == "some title"
      assert photo.url == "some url"
      assert photo.user == "some user"
    end

    test "create_photo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Photos.create_photo(@invalid_attrs)
    end

    test "update_photo/2 with valid data updates the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{} = photo} = Photos.update_photo(photo, @update_attrs)
      assert photo.date == "some updated date"
      assert photo.description == "some updated description"
      assert photo.title == "some updated title"
      assert photo.url == "some updated url"
      assert photo.user == "some updated user"
    end

    test "update_photo/2 with invalid data returns error changeset" do
      photo = photo_fixture()
      assert {:error, %Ecto.Changeset{}} = Photos.update_photo(photo, @invalid_attrs)
      assert photo == Photos.get_photo!(photo.id)
    end

    test "delete_photo/1 deletes the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{}} = Photos.delete_photo(photo)
      assert_raise Ecto.NoResultsError, fn -> Photos.get_photo!(photo.id) end
    end

    test "change_photo/1 returns a photo changeset" do
      photo = photo_fixture()
      assert %Ecto.Changeset{} = Photos.change_photo(photo)
    end
  end
end
