class UpgradeIdsToBigints < ActiveRecord::Migration[7.2]
  def up
    change_column :blogs, :id, :bigint

    change_column :contents, :id, :bigint
    change_column :contents, :user_id, :bigint
    change_column :contents, :parent_id, :bigint
    change_column :contents, :blog_id, :bigint

    change_column :contents_tags, :content_id, :bigint
    change_column :contents_tags, :tag_id, :bigint

    change_column :feedback, :id, :bigint
    change_column :feedback, :user_id, :bigint
    change_column :feedback, :article_id, :bigint

    change_column :pings, :id, :bigint
    change_column :pings, :article_id, :bigint

    change_column :post_types, :id, :bigint

    change_column :redirects, :id, :bigint
    change_column :redirects, :content_id, :bigint
    change_column :redirects, :blog_id, :bigint

    change_column :resources, :id, :bigint
    change_column :resources, :content_id, :bigint
    change_column :resources, :blog_id, :bigint

    change_column :sessions, :id, :bigint

    change_column :sidebars, :id, :bigint
    change_column :sidebars, :blog_id, :bigint

    change_column :tags, :id, :bigint
    change_column :tags, :blog_id, :bigint

    change_column :triggers, :id, :bigint

    change_column :users, :id, :bigint
    change_column :users, :resource_id, :bigint
  end

  def down
    change_column :blogs, :id, :integer

    change_column :contents, :id, :integer
    change_column :contents, :user_id, :integer
    change_column :contents, :parent_id, :integer
    change_column :contents, :blog_id, :integer

    change_column :contents_tags, :content_id, :integer
    change_column :contents_tags, :tag_id, :integer

    change_column :feedback, :id, :integer
    change_column :feedback, :user_id, :integer
    change_column :feedback, :article_id, :integer

    change_column :pings, :id, :integer
    change_column :pings, :article_id, :integer

    change_column :post_types, :id, :integer

    change_column :redirects, :id, :integer
    change_column :redirects, :content_id, :integer
    change_column :redirects, :blog_id, :integer

    change_column :resources, :id, :integer
    change_column :resources, :content_id, :integer
    change_column :resources, :blog_id, :integer

    change_column :sessions, :id, :integer

    change_column :sidebars, :id, :integer
    change_column :sidebars, :blog_id, :integer

    change_column :tags, :id, :integer
    change_column :tags, :blog_id, :integer

    change_column :triggers, :id, :integer

    change_column :users, :id, :integer
    change_column :users, :resource_id, :integer
  end
end
