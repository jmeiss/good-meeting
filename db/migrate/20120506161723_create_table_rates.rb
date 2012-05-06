class CreateTableRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.string :gcal_id
      t.integer :mark
      t.integer :user_id
    end
  end
end
