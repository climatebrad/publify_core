# frozen_string_literal: true

class Theme
  attr_reader :name, :path

  def initialize(name, path)
    @name = name
    @path = path
  end

  def layout(action = :default)
    if action.to_s == "view_page" && (File.exist? "#{view_path}/layouts/pages.html.erb")
      return "layouts/pages"
    end

    "layouts/default"
  end

  def description
    @description ||=
      begin
        about_file = theme_file("about.markdown")
        if File.exist? about_file
          File.read about_file
        else
          "### #{name}"
        end
      end
  end

  def description_html
    TextFilter.markdown.filter_text(description)
  end

  def view_path
    "#{path}/views"
  end

  def theme_file(filename)
    File.join(path, filename)
  end

  # Find a theme, given the theme name
  def self.find(name)
    registered_themes[name]
  end

  # List all themes
  def self.find_all
    registered_themes.values
  end

  def self.register_theme(path)
    theme = theme_from_path(path)
    registered_themes[theme.name] = theme
  end

  def self.register_themes(themes_root)
    search_theme_directory(themes_root).each do |path|
      register_theme path
    end
  end

  # Private

  def self.registered_themes
    @registered_themes ||= {}
  end

  def self.theme_from_path(path)
    name = path.scan(/[-\w]+$/i).flatten.first
    new(name, path)
  end

  def self.search_theme_directory(themes_root)
    glob = "#{themes_root}/[a-zA-Z0-9]*"
    Dir.glob(glob).select do |file|
      File.readable?("#{file}/about.markdown")
    end.compact
  end

  private_class_method :search_theme_directory,
                       :theme_from_path, :registered_themes
end
