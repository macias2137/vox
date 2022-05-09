defmodule Vox.UserManager.Pipeline do
  use Guardian.Plug.Pipeline,
  otp_app: :vox,
  error_handler: Vox.UserManager.ErrorHandler,
  module: Vox.UserManager.Guardian


end
