module ApplicationHelper

  def full_title(page_title)
    base_title = t(:base_title)
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def active_link(path)
    "active" if current_page?(path)
  end

  def active_link?(path)
    data = '<div class="pointer">
              <div class="arrow"></div>
              <div class="arrow_border"></div>
            </div>'
    if current_page?(path)
      data.html_safe
    else
      nil
    end
  end

end
