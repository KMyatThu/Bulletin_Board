class ErrorsController < ApplicationController

  def not_found
    render status: 404
  end
  
  # for internal server error 500
  def internal_server_error
    render status: 500
  end
end
