class CreateSupportEngineTickets < ActiveRecord::Migration
  def change
    create_table :support_engine_tickets do |t|
      t.string :title, null: false
      t.string :body

      t.references :user
      t.references :assignee

      t.string :name
      t.string :email

      t.integer :state, null: false
      t.integer :priority, null: false

      t.timestamps
    end
  end
end
