module EventsHelper

  def label_mark rate, current_user_rate
    if 
      classes = 'badge'
      if rate
        classes = 'badge badge-error' if rate.mark > 0
        classes = 'badge badge-warning' if rate.mark == 3
        classes = 'badge badge-success' if rate.mark > 3
      end
      content_tag :span, class: classes do
        rate ? rate.mark.to_s : '?'
      end
    else
      content_tag(:span, class: 'badge') { '?' }
    end
  end

end