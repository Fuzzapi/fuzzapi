module ApplicationHelper
  def tr_class type
    case type
    when 'MEDIUM'
      'table-warning'
    when 'HIGH'
      'table-danger'
    when 'LOW'
      'table-success'
    when 'INFORMATIVE'
      'table-info'
    end
  end
end
