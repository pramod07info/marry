class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :mobile
      t.string :user_name
      t.string :password
      t.string :unique_code
      t.string :device_code

      t.timestamps
    end
  end
end
