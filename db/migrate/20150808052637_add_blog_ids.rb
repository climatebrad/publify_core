# frozen_string_literal: true

class AddBlogIds < ActiveRecord::Migration[4.2]
  class Blog < ActiveRecord::Base; end

  class Content < ActiveRecord::Base; end

  class Sidebar < ActiveRecord::Base; end

  def up
    add_column :contents, :blog_id, :integer
    add_column :sidebars, :blog_id, :integer

    if Content.any? || Sidebar.any?
      default_blog_id = Blog.order(:id).first.id

      Content.update_all("blog_id = #{default_blog_id}")
      Sidebar.update_all("blog_id = #{default_blog_id}")
    end

    change_column :sidebars, :blog_id, :integer, null: false
  end

  def down
    if adapter_name == "PostgreSQL"
      indexes(:contents).each do |index|
        remove_index(:contents, name: index.name) if index.name.include?("blog_id")
      end
    else
      begin
        remove_index :contents, :blog_id
      rescue StandardError
        nil
      end
    end
    remove_column :contents, :blog_id
    remove_column :sidebars, :blog_id
  end
end
