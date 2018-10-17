defmodule Discuss.AuthController do
    use Discuss.Web, :controller
    plug Ueberauth
  
    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider} = params) do
        IO.puts "+++++"
        IO.inspect(conn.assigns)
        IO.puts "+++++"
        IO.inspect(params)
        IO.puts "+++++"

        user_params = %{token: auth.credentials.token, email: auth.info.email, provider: provider}

        changeset = Discuss.User.changeset(%Discuss.User{}, user_params)

        IO.puts("**********")
        IO.inspect(changeset)

        insert_or_update_user(changeset)
    end

    defp insert_or_update_user(%Ecto.Changeset{changes: %{email: email}} = changeset) do
        IO.puts("###########")
        IO.inspect(email)

        case Repo.get_by(Discuss.User, email: email) do
            user ->
                {:ok, user}
            nil ->
                Repo.insert(changeset)
        end
    end
end
