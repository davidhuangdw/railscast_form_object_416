class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true
      t.string :twitter_name
      t.string :github_name
      t.text :bio

      t.timestamps
    end
  end
end
