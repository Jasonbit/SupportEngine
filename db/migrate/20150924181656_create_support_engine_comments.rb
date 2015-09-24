class CreateSupportEngineComments < ActiveRecord::Migration
  def change
    create_table :support_engine_comments do |t|
      t.text :content
      t.references :user
      t.references :ticket

      t.timestamps
    end
  end
end
