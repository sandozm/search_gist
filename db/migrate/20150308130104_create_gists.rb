class CreateGists < ActiveRecord::Migration
  def change
    create_table :gists do |t|
      t.string :id_gist
      t.text :description
      t.string :owner
      t.string :avatar_url
      t.string :html_url

      t.timestamps null: false
    end
  end
end
