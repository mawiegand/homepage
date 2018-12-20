module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  def site_class(page_site_class)
    content_for(:site_class) { page_site_class }
  end
end
