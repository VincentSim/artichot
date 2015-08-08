class AddCategoryToEspaces < ActiveRecord::Migration
  def change
    add_column :espaces, :category, :string
  end
end
