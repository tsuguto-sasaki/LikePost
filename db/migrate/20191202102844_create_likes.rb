class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :member, foreign_key: true
      t.references :tweet, foreign_key: true

      t.timestamps
      
      t.index [:member_id, :tweet_id],unique: true
    end
  end
end
