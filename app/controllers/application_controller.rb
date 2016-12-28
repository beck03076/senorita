require 'github/error'
# Implement methods used by all controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # exception handling in controller level
  rescue_from Github::InvalidUsername, with: :redirect_to_index
  rescue_from Github::UserNotFound, with: :redirect_to_index
  rescue_from Github::InvalidResponse, with: :redirect_to_index

  def favorito
    render 'shared/favorito', layout: false
  end

  private

  def redirect_to_index(exception)
    redirect_to :root, notice: exception.to_s
  end
end
