class AddRetweetFlag < ActiveRecord::Migration
  def change
    add_column :microposts, :retweet_flag, :boolean
  end
end
