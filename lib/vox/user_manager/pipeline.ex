defmodule Vox.UserManager.Pipeline do
  use Guardian.Plug.Pipeline,
  otp_app: :vox,
  error_handler: Vox.UserManager.ErrorHandler,
  module: Vox.UserManager.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
