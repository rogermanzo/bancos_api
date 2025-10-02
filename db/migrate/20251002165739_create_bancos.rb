class CreateBancos < ActiveRecord::Migration[7.2]
  def change
    create_table :bancos do |t|
      t.string :nombre
      t.string :direccion
      t.decimal :latitud
      t.decimal :longitud

      t.timestamps
    end
  end
end
