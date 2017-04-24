require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class Grid < Index
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :route_fragment do
          'grid'
        end

        register_instance_option :controller do
          proc do
            unless @model_config.grid.visible
              redirect_to index_path(model_name: @abstract_model)

            else
              @objects ||= list_entries

              unless @model_config.grid.scopes.empty?
                if params[:scope].blank?
                  unless @model_config.grid.scopes.first.nil?
                    @objects = @objects.send(@model_config.grid.scopes.first)
                  end
                elsif @model_config.grid.scopes.collect(&:to_s).include?(params[:scope])
                  @objects = @objects.send(params[:scope].to_sym)
                end
              end

              render @action.template_name, status: (flash[:error].present? ? :not_found : 200)
            end
          end
        end

        register_instance_option :visible do
          bindings[:abstract_model].config.grid.visible
        end

        register_instance_option :thumbnail_method do
          nil
        end

        register_instance_option :html_method do
          nil
        end

        register_instance_option :link_icon do
          'icon-th-large'
        end
      end
    end
  end
end
