class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :token
      t.string :username
      t.datetime :subscribed_at

      t.timestamps
    end
  end
end
