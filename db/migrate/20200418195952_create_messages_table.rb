class CreateMessagesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.column :body, :string, null: false
      t.references :sender, index: true, foreign_key: { to_table: :users }, null: false
      t.references :recipient, index: true, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
