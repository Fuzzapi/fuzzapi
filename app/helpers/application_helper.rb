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

  def badge type
    case type
    when 'MEDIUM'
      'tag-primary'
    when 'HIGH'
      'tag-danger'
    when 'LOW'
      'tag-success'
    when 'INFORMATIVE'
      'tag-info'
    end
  end
end
