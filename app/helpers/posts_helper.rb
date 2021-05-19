module PostsHelper
  def self.check_header(expected_header,csv_file)
    header = CSV.open(csv_file, 'r') { |csv| csv.first }
    error_msg = "" 
    for i in (0..header.size-1)
      if (header.size != 3)
        error_msg = Messages::POST_UPLOAD_HEADER_COLUMN
      elsif header[i].downcase != expected_header[i].downcase
        error_msg = Messages::POST_UPLOAD_WRONG_HEADER
      end
    end
    return error_msg
  end
end
