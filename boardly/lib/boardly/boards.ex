defmodule Boardly.Boards do
  @moduledoc """
  The Boards context.
  """

  import Ecto.Query, warn: false
  alias Boardly.Repo

  alias Boardly.Boards.Board
  alias Boardly.Lists.List
  alias Boardly.Accounts.User
  alias Boardly.Accounts

  @doc """
  Returns the list of boards.

  ## Examples

      iex> list_boards()
      [%Board{}, ...]

  """
  def list_boards do
    Repo.all(Board)
  end

  # preload cards
  def get_board_with_lists(board_id) do
    Repo.get!(Board, board_id)
    |> Repo.preload(lists: [:cards])
  end

  def get_board_with_users(board_id) do
    Repo.get!(Board, board_id)
    |> Repo.preload(:users)
  end

  def invite_user_to_board(user_email, board_id) do
    # boards = Repo.get!(Board, board_id) |> Repo.preload(:users)
    case Accounts.get_user_by_email(user_email) do
      nil ->
        {:error, "User not found"}

      %User{} = user ->
        case Repo.get(Boardly.Boards.Board, board_id) do
          nil ->
            {:error, "Board not found"}

          %Board{} = _board ->
            if user.board_id == board_id do
              {:error, "User is already a member of this board."}
            else
              changeset =
                user
                |> Ecto.Changeset.change(%{board_id: board_id})

              case Repo.update(changeset) do
                {:ok, _updated_user} ->
                  {:ok, "#{user_email} has been invited to the board."}

                {:error, changeset} ->
                  {:error, "Failed to invite user: #{inspect(changeset.errors)}"}
              end
            end
        end
    end
  end

  def remove_user_from_board(user_id) do
    case Repo.get(Boardly.Accounts.User, user_id) do
      nil ->
        {:error, "User not found"}

      %User{} = user ->
        changeset =
          user
          |> Ecto.Changeset.change(%{board_id: nil})

        case Repo.update(changeset) do
          {:ok, _updated_user} ->
            {:ok, "#{user.email} has been removed from the board."}

          {:error, changeset} ->
            {:error, "Failed to remove user: #{inspect(changeset.errors)}"}
        end
    end
  end

  @doc """
  Gets a single board.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board!(123)
      %Board{}

      iex> get_board!(456)
      ** (Ecto.NoResultsError)

  """
  def get_board!(id), do: Repo.get!(Board, id)

  def get_lists_by_board(board_id) do
    Repo.all(from l in List, where: l.board_id == ^board_id)
  end

  @doc """
  Creates a board.

  ## Examples

      iex> create_board(%{field: value})
      {:ok, %Board{}}

      iex> create_board(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_board(attrs \\ %{}) do
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a board.

  ## Examples

      iex> update_board(board, %{field: new_value})
      {:ok, %Board{}}

      iex> update_board(board, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_board(%Board{} = board, attrs) do
    board
    |> Board.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a board.

  ## Examples

      iex> delete_board(board)
      {:ok, %Board{}}

      iex> delete_board(board)
      {:error, %Ecto.Changeset{}}

  """
  def delete_board(%Board{} = board) do
    Repo.delete(board)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking board changes.

  ## Examples

      iex> change_board(board)
      %Ecto.Changeset{data: %Board{}}

  """
  def change_board(%Board{} = board, attrs \\ %{}) do
    Board.changeset(board, attrs)
  end
end
