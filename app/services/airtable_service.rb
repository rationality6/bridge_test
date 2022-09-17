class AirtableService

  attr_accessor :json_data

  def initialize()
    @json_data
    # set in dot env config later
    @base_id = "appvjNj2O2RtWKn5O"
    @table_name = "Table%201"
  end

  def get_airtable_data
    @airtable_api_key = "keyUXowuZjbhgMG6U"
    airtable_response = Faraday.get(
      base_url,
      {},
      { "Authorization": "Bearer #{@airtable_api_key}" })

    parsed_result = parse_body(airtable_response)
    parsed_result
  end


  def save_file_as_json
    airtable_data_response = get_airtable_data

    File.open("public/copy.json","w") do |f|
      f.write(airtable_data_response.to_json)
    end
  end

  private

  def base_url
    "https://api.airtable.com/v0/#{@base_id}/#{@table_name}"
  end

  def parse_body(response)
    JSON.parse(response.env['response_body'])
  end

end