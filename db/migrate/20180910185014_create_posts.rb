class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user
      t.string     :title,      null: false
      t.text       :content,    null: false
      t.string     :ip,         null: false
      t.integer    :rate_sum,   default: 0
      t.integer    :rate_count, default: 0
      t.timestamps
    end
  end
end
