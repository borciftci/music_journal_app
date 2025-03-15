class AddFavoriteToMusicLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :music_logs, :favorite, :boolean
  end
end
