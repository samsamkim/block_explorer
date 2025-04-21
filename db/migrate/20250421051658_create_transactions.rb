class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :tx_hash
      t.string :block_hash
      t.integer :block_height
      t.string :sender
      t.string :receiver
      t.string :deposit
      t.datetime :tx_time
      t.jsonb :actions
      t.string :gas_burnt
      t.boolean :success
      t.integer :action_count

      t.timestamps
    end

    add_index :transactions, :tx_hash, unique: true
  end
end
