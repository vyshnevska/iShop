module ApplicationHelper
  def bootstrap_class_for flash_type
    { :success => 'alert-success',
      :error   => 'alert-danger',
      :alert   => 'alert-warning',
      :notice  => 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def btn_class_for btn_type
    { new: 'btn btn-primary',
      edit: 'btn btn-info',
      destroy: 'btn btn-danger',
      default: 'btn btn-default',
      empty: 'btn btn-warning',
      add_to_cart: 'btn btn-warning'
    }[btn_type] || 'btn btn-default'
  end

  def xs_btn_class_for btn_type
    { destroy: 'btn btn-primary btn-xs',
      default: 'btn btn-default btn-xs'
    }[btn_type] || 'btn btn-default btn-xs'
  end
end
