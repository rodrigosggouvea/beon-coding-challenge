class CursorPaginator
  def initialize(all_records, before_id)
    @all_records = all_records.order(created_at: :desc)
    @before_id = before_id
    @per_page = per_page
  end

  def paginate
    {
      page_info: {
        has_previous_page: previous_page?,
        has_next_page: next_page?,
        total: all_records.count,
        start_cursor: records.first.id,
        end_cursor: records.last.id
      },
      page: records
    }
  end

  attr_accessor :all_records, :before_id, :per_page

  private

  def previous_page?
    records.first != all_records.first
  end

  def next_page?
    records.last != all_records.last
  end

  def records
    query = all_records
    query = query.where("#{all_records.table_name}.created_at < ?", cursor) if cursor
    query.limit(10)
  end

  def cursor
    return if before_id.blank?

    all_records.find(before_id).created_at
  end
end
