class CreateLocks < ActiveRecord::Migration[5.0]
  def change
    create_table :locks do |t|
      t.string :name, limit: 30
      t.boolean :locked

      t.timestamps
    end
    add_index :locks, :name, unique: true
  end
end
