class LengthenRedirectToPaths < ActiveRecord::Migration[7.1]
  def change
    change_column :redirects, :to_path, :text
  end
end
