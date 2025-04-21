class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :tx_hash
      t.string :block_hash
      t.integer :block_height
      t.string :sender
      t.string :receiver
      t.decimal :deposit, precision: 40, scale: 0
      t.datetime :tx_time
      t.jsonb :actions
      t.string :gas_burnt
      t.boolean :success
      t.integer :actions_count

      t.timestamps
    end
  end
end
