# frozen_string_literal: true 

module Pagination
  def collection 
    @collection ||= send("#{self.class.name.gsub("Controller", "").downcase}")
  end

  def paginated_collection
    @paginated_collection ||= collection.page(params[:page] || 1).per(self.class::DEFAULT_PER_PAGE)
  end

  def meta
    {
      current: paginated_collection.current_page,
      next: paginated_collection.next_page,
      pages: paginated_collection.total_pages,
      total: paginated_collection.total_count,
    } if paginated_collection.present?
  end
end