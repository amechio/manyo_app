class ChangeTitleColumnOnTask < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :title, false, 0
  end
end
