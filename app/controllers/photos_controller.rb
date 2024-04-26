class PhotosController < ApplicationController
  before_action :require_login, only: %i[index new create]

  def index;end

  def new;end

  def create
    # NOTE: 同じ名前のファイル名がきた場合でもユニークな識別子になるようuuid付与
    file_name = photo_params[:image] ? SecureRandom.uuid + '_' + File.extname(photo_params[:image].original_filename) : nil
    @photo = Photo.new(user_id: current_user.id, title: photo_params[:title], file_name:)
    save_file(file_name)
    @photo.save!

    redirect_to photos_path
  rescue => e
    logger.error "画像保存の処理の中でエラーが起きました。ErrorClass: #{e.class}, backtrace: #{e.backtrace}"
    FileUtils.rm(output_path(file_name)) if File.exist?(output_path(file_name))

    redirect_to photos_path
  end

  private

  def photo_params
    params.permit(:title, :image)
  end

  def dir_path
    "public/photo/#{current_user.id}/"
  end

  def output_path(file_name)
    Rails.root.join(dir_path, file_name)
  end

  def save_file(file_name)
    FileUtils.mkdir_p(dir_path)
    File.binwrite(output_path(file_name), File.read(photo_params[:image].tempfile))
  end
end
