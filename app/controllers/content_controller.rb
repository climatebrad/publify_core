# frozen_string_literal: true

class ContentController < BaseController
  private

  # TODO: Make this work for all content.
  def auto_discovery_feed(options = {})
    with_options(options.reverse_merge(only_path: true)) do
      @auto_discovery_url_rss = url_for(format: "rss", only_path: false)
      @auto_discovery_url_atom = url_for(format: "atom", only_path: false)
    end
  end

  def theme_layout
    this_blog.current_theme.layout(action_name)
  end

  def render_cached_xml(template, object)
    feed = cache([controller_name, template, object]) do
      render_to_string template, layout: false
    end
    render xml: feed
  end

  def verify_config
    if !this_blog.configured?
      redirect_to controller: "setup", action: "index"
    elsif User.count == 0
      redirect_to new_user_registration_path
    else
      true
    end
  end
end
