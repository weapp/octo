class CreateCephalopods < ActiveRecord::Migration
  def change
    create_table :cephalopods do |t|
      t.string :name
      t.integer :tentacles

      t.timestamps
    end
  end
end
