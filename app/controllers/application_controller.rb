class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def main
    render html: "<h1>Hello, World!</h1>".html_safe
  end

end
