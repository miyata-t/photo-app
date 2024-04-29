class Photo < ApplicationRecord
  belongs_to :user

  validates :title, presence: { message: 'タイトルを入力してください。' },
                    length: { maximum: 30, too_long: 'タイトルは最大%<count>s文字までです。' }
  validates :file_name, presence: { message: '画像ファイルを指定してください。' }
end
