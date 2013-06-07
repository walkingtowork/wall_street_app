class AddClientIdToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :client_id, :integer
  end
end
