class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.text :description
      t.boolean :is_processed, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
