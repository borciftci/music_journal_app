class CreateMusicLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :music_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.string :song_name
      t.string :artist
      t.string :mood
      t.text :notes
      t.string :status

      t.timestamps
    end
  end
end
