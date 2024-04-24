class SessionsController < ApplicationController
  def new;end

  def create
    redirect_to photos_path
  end
end
