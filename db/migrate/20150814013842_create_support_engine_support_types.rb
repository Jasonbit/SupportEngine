class CreateSupportEngineSupportTypes < ActiveRecord::Migration
  def change
    create_table :support_engine_support_types do |t|
      t.string :name, :email

      t.timestamps
    end

    add_column :support_engine_tickets, :support_type_id, :integer
    add_index :support_engine_tickets, :support_type_id

    ["Question", "Idea", "Feedback", "Other"].each do |name|
      SupportEngine::SupportType.create(name: name)
    end
  end
end
