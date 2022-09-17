class AirtableService
  #json data for original airtable data
  # hashmap_cache for optimized search
  attr_accessor :json_data, :hashmap_cache

  def initialize()
    @json_data
    @hashmap_cache = {}
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

    @json_data = parse_body(airtable_response)
    @json_data
  end

  def parse_datetime(string)
    string.gsub
  end

  def parse_value_by_key(params)
    found_object = detect_by(params['key'])
    field_value = found_object['fields']['Copy']

    parsed_value = parse_curly(field_value, params)

    parsed_value
  end

  def save_file_as_json
    airtable_data_response = get_airtable_data

    File.open("public/copy.json", "w") do |f|
      f.write(airtable_data_response.to_json)
    end
  end

  private

  def parse_curly(string, params)
    # regex select between { and }
    regex_selecter = /\{(.*?)\}/

    result = string.gsub(regex_selecter) do |curly_word|
      regex = /datetime/

      binding.pry

      if curly_word.match(regex)
        binding.pry
      else
        removed_word = remove_curly_bracket(curly_word)
        "#{params[removed_word]}"
      end
    end

    result
  end

  def remove_curly_bracket(string)
    # regex remove { and }
    regex_remover = /[{}]/

    result = string.gsub(regex_remover, "")

    result
  end

  def detect_by(key)
    key_object = @json_data['records'].detect do |item|
      item['fields']['Key'] == key
    end

    key_object
  end

  def base_url
    "https://api.airtable.com/v0/#{@base_id}/#{@table_name}"
  end

  def parse_body(response)
    JSON.parse(response.env['response_body'])
  end

end