module Admin::AccountDetailsHelper
  def span_sum_class(sum)
    if sum>0
      'label-success'
    elsif sum<0
      'label-danger'
    else
      'label-default'
    end
  end
end
