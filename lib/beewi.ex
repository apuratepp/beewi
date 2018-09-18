defmodule Beewi do
  require Logger
  require Record

  Record.defrecord :file_info, [:type, :name, :mode, :uid, :gid, :size, :mtime, :module_info]

  def init(arg, _) do
    arg
  end

  def login(state, _user, _pass) do
    {true, state}
  end

  def current_directory(_state) do
    '/'
  end

  def change_directory(state, _directory) do
    {:ok, state}
  end

  def list_files(_state, _directory) do
    [
      file_info(type: :file, name: 'Fake', mode: 0511, uid: 0, gid: 0, size: 1_048_576, mtime: :erlang.localtime()),
      file_info(type: :dir, name: '.', mode: 0511, uid: 0, gid: 0, size: 20, mtime: :erlang.localtime()),
      file_info(type: :dir, name: '..', mode: 0511, uid: 0, gid: 0, size: 20, mtime: :erlang.localtime()),
    ]
  end

  def make_directory(state, _directory) do
    {:ok, state}
  end

  def put_file(state, file_name, _mode, fun) do
    {:ok, file_bytes, _file_size} = read_from_fun(fun)

    log(file_name)
    path = Path.join(["/Users/josepsirvent/Desktop", file_name])
    File.write(path, file_bytes)

    Task.async(fn -> send_photo(path) end)

    {:ok, state}
  end

  def send_photo(path) do
    Nadia.send_photo(Application.get_env(:beewi, :telegram_user_id), path)
  end

  def read_from_fun(fun) do
    read_from_fun([], 0, fun)
  end

  def read_from_fun(buffer, count, fun) do
    case fun.() do
      {:ok, bytes, read_count} -> read_from_fun(buffer ++ [bytes], count + read_count, fun)
      :done -> {:ok, buffer, count}
    end
  end

  def disconnect(_state) do
    :ok
  end

  defp log(message) do
    message
    |> inspect
    |> Logger.debug

    message
  end
end
