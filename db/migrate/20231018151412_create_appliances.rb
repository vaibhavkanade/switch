class CreateAppliances < ActiveRecord::Migration[7.0]
  def change
    create_table :appliances do |t|
      t.string :name
      t.boolean :state

      t.timestamps
    end
  end
end
