class CreateTokens < ActiveRecord::Migration
  def self.up
    create_table :tokens do |t|
      t.references :user
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :tokens
  end
end
