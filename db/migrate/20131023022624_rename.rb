class Rename < ActiveRecord::Migration
  def up
    rename_column :links, :short, :code
  end

  def down
    rename_column :lnks, :code, :short
  end
end
