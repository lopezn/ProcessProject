class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
	  t.integer :votes, :default => 0

      t.timestamps
    end
  end
end
