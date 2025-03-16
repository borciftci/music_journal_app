class AddFavoriteSongToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :favorite_song_id, :bigint
    add_foreign_key :users, :music_logs, column: :favorite_song_id, on_delete: :nullify
  end
end
