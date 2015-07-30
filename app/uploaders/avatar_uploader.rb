# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  
  # リサイズしたり画像形式を変更するのに必要
  include CarrierWave::RMagick
  
  # 画像の上限を700pxにする
  # process :resize_to_limit => [700, 700]
  
  # 保存形式をJPGにする
  process :convert => 'jpg'
  
  # サムネイルを生成する設定
  version :small do
    process :resize_to_fill => [50, 50]
  end
  
  version :medium do
    process :resize_to_fill => [80, 80]
  end
  
  
  
  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

  storage :file
  
  # ファイルを入れるディレクトリを指定
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
