class AddIntoductionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :introduction, :text
  end
  
  # 追加した記述
  def change
    add_index :users, :name, unique: true
  end
end
