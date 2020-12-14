class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users
    t.timestamps
  end
end
