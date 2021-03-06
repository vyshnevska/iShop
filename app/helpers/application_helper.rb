module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: 'alert-success',
      error:   'alert-danger',
      alert:   'alert-warning',
      notice:  'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def btn_class_for btn_type = 'btn btn-default'
    { new:      'btn btn-primary',
      edit:     'btn btn-info',
      destroy:  'btn btn-danger',
      default:  'btn btn-default',
      cart:     'btn btn-warning'
    }[btn_type]
  end

  def xs_btn_class_for btn_type
    { cart:    'btn btn-warning btn-xs',
      destroy: 'btn btn-primary btn-xs',
      default: 'btn btn-default btn-xs'
    }[btn_type] || 'btn btn-default btn-xs'
  end

  def hidden_div_if condition, attributes = {}, &block
    attributes['style'] = 'display: none' if condition
    content_tag("div", attributes, &block)
  end

  def link_to_action(title, url = {}, options = {})
    link_to(title, url_for(controller: url[:controller], action: url[:action]), options) if controller.respond_to?(url[:action]) if rollout?(:editing)
  end

  def link_to_with_access(*args, &block)
    link_to(*args, &block) if rollout?(:editing)
  end
end
