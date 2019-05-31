class CreateUserGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :user_groups, id: :uuid do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
