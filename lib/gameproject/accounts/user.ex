defmodule Gameproject.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gameproject.Accounts.{User, Encryption}

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :username, :string
    ## Virtual Fields ##
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @required_fields ~w(email username password)
  @optional_fields ~w()

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> downcase_email
    |> encrypt_password
  end

  ## Encrypt the password using hash_password
  def encrypt_password(changeset) do
    password = get_change(changeset, :password)
    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :password_hash, encrypted_password)
    else
      changeset
    end
  end

  ## Change all email letters to lowercases
  def downcase_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end

end
