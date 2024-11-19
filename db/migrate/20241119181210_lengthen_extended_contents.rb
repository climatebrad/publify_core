class LengthenExtendedContents < ActiveRecord::Migration[7.1]
  def up
    change_column :contents, :extended, :text, limit: 4294967295
  end

  def down
    change_column :contents, :extended, :text, limit: nil
  end
end
