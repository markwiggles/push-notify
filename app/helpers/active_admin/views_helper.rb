module ActiveAdmin::ViewsHelper # camelized file name
 def create_action_icons(resource)
  links = ''.html_safe
  links += link_to '<i class="fa fa-search fa-lg image-link"></i>'.html_safe, resource_path(resource)
  links += link_to '<i class="fa fa-edit fa-lg image-link"></i>'.html_safe, edit_resource_path(resource)
  links += link_to '<i class="fa fa-close fa-lg image-link"></i>'.html_safe, resource_path(resource),
                   method: :delete, data: { confirm: 'Are you sure?' }, class: 'pull-right'
  links
	end
end
