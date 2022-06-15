class ApplicationController < ActionController::API
  private

  def paginate(all_records)
    CursorPaginator.new(all_records, params[:before]).paginate
  end
end
