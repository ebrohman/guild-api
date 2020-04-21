class CreateUsersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.column :name, :string, null: false
      t.column :email, :string, null: false
      t.column :settings, :jsonb, default: -> { "'{}'" }
      t.timestamps
    end
  end
end
