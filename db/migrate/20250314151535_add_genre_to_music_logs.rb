class AddGenreToMusicLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :music_logs, :genre, :string
  end
end
