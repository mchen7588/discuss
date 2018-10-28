defmodule Discuss.CommentsChannel do
    use Discuss.Web, :channel

    def join(name, _params, socket) do  # this is called when a javascript client connect to this channel
        IO.puts("*************")
        IO.puts(name)

        {:ok, %{what: "what"}, socket}
    end

    def handle_in() do
        
    end
    
end