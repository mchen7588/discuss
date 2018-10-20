defmodule Discuss.AuthController do
    use Discuss.Web, :controller
    plug Ueberauth
    alias Discuss.User
  
    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider} = params) do
        user_params = %{token: auth.credentials.token, email: auth.info.email, provider: provider}
        changeset = User.changeset(%User{}, user_params)

        signin(conn, changeset)
    end

    defp signin(conn, changeset) do
        case insert_or_update_user(changeset) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "welcome")
                |> put_session(:user_id, user.id)
                |> redirect(to: topic_path(conn, :index))
            {:error, _changeset} ->
                conn
                |> put_flash(:error, "oh nooo")
                |> redirect(to: page_path(conn, :index))
        end
    end

    defp insert_or_update_user(%Ecto.Changeset{changes: %{email: email}} = changeset) do
        case Repo.get_by(User, email: email) do
            user ->
                {:ok, user}
            nil ->
                Repo.insert(changeset)
        end
    end

    def signout(conn, _params) do
        conn
        |> configure_session(drop: true)
        |> put_flash(:info, "signed out")
        |> redirect(to: page_path(conn, :index))
    end
end
