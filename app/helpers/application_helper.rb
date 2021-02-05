module ApplicationHelper
  def error_class errors
    errors.nil? ? 'no_display' : 'errors'
  end
end
