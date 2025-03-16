class RemoveFavoriteFromMusicLogs < ActiveRecord::Migration[8.0]
  def change
    remove_column :music_logs, :favorite, :boolean
  end
end
