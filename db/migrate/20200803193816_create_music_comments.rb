class CreateMusicComments < ActiveRecord::Migration[5.2]
  def change
    create_table :music_comments do |t|
    	  t.references :user, foreign_key: true
      t.references :music, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
