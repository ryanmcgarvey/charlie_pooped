class AddEvent < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.datetime :occurred_at, null: false
      t.datetime :finished
      t.string :activity, null: false, index: true
      t.string :comments
      t.timestamps
    end
  end
end
