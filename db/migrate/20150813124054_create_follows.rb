class CreateFollow < ActiveRecord::Migration
  def change
    create_table :follow do |t|
      t.references :user, index: true
      t.references :espace, index: true

      t.timestamps
    end
  end
end
