module UsersHelper

  def display_time_in_words event_end
    ends_at = (event_end['dateTime'] || event_end['date']).to_time

    if ends_at > Time.zone.now
      "ends in #{time_ago_in_words(ends_at)}"
    else
      "ended since #{time_ago_in_words(ends_at)}"
    end
  end

end