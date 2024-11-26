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
   def list_boards(user_id) do
    from(b in Board,
      where: b.user_id == ^user_id,
      order_by: [desc: b.inserted_at]
    )
    |> Repo.all()
  end

  # preload cards
  def get_board!(id, user_id) do
    from(b in Board,
      where: b.id == ^id and b.user_id == ^user_id
    )
    |> Repo.one!()
  end

  def get_board_with_users(board_id) do
    Repo.get!(Board, board_id)
    |> Repo.preload(:users)
  end

   def get_board_with_lists(id, user_id) do
    from(b in Board,
      where: b.id == ^id and b.user_id == ^user_id,
      preload: [lists: [cards: []]]
    )
    |> Repo.one()
  end

  @doc """
  Gets a single board.

  Raises `Ecto.NoResultsError` if the Board does not exist or doesn't belong to the user.

  ## Examples

      iex> get_board!(123, user_id)
      %Board{}

      iex> get_board!(456, user_id)
      ** (Ecto.NoResultsError)

  """

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
    try do
      Repo.delete(board)
    rescue
      _e in Ecto.ConstraintError ->
        {:error, Ecto.Changeset.change(board) |> Ecto.Changeset.add_error(:id, "Cannot delete board with existing lists or cards")}
      _ ->
        {:error, Ecto.Changeset.change(board) |> Ecto.Changeset.add_error(:id, "Something went wrong")}
    end
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
