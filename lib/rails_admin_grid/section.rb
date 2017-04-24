# require 'rails_admin/config/sections'
require 'rails_admin/config/sections/list'

module RailsAdmin
  module Config
    module Sections
      # Configuration of the explore view
      class Grid < List
        register_instance_option :thumbnail_method do
          nil
        end
        register_instance_option :html_method do
          nil
        end
      end
    end
  end
end
RailsAdmin::Config::Model.send :include, RailsAdmin::Config::Sections
