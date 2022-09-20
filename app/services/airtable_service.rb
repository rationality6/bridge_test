class AirtableService
  #json data for original airtable data
  # airtable_hashmap for optimized search
  attr_accessor :json_data, :airtable_hashmap

  def initialize()
    @json_data
    @airtable_hashmap = {}

    # set in dot env config later
    @base_id = "appvjNj2O2RtWKn5O"
    @airtable_api_key = "keyUXowuZjbhgMG6U"
    @table_name = "Table%201"
  end

  def get_airtable_data
    airtable_response = Faraday.get(
      base_url,
      {},
      { "Authorization": "Bearer #{@airtable_api_key}" })

    @json_data = parse_body(airtable_response)

    # set hashmap
    set_hash(@json_data)

    save_file_as_json(@json_data)

    @json_data
  end

  def parse_datetime(string)
    string.gsub
  end

  def parse_value_by_key(params)
    field_value = airtable_hashmap[params['key']]
    parsed_value = parse_curly_recursive(field_value, params, "")

    parsed_value
  end

  def save_file_as_json(data)

    File.open("public/copy.json", "w") do |f|
      f.write(data.to_json)
    end
  end

  def load_file_as_json
    file = File.read('./public/copy.json')
    data_hash = JSON.parse(file)

    @json_data = data_hash
    set_hash(@json_data)
  end

  def converte_epoch_time(epoch_time)
    date_time = Time.at(epoch_time.to_i).to_datetime() - 9.hours
    result = date_time.strftime("%a %b %d %I:%M:%S %p")
    result
  end

  def set_hash(data)
    data['records'].each do |record|
      @airtable_hashmap[record['fields']['Key']] = record['fields']['Copy']
    end
  end

  private

  def parse_curly_recursive(string, params, accumulator)
    # regex select between { and }
    regex_selecter = /\{(.*?)\}/

    string.gsub(regex_selecter) do |curly_wrap_word|
      word = remove_curly_bracket(curly_wrap_word)

      regex_datetime = /datetime/
      if word.match(regex_datetime)

        # when time come
        regex_before_datetime_word = /.+?(?=,)/
        mached_word = word.match(regex_before_datetime_word).to_s
        converte_epoch_time(params[mached_word].to_i)
      elsif airtable_hashmap[word].present?

        # when nested
        parse_curly_recursive(airtable_hashmap[word], params, accumulator + "#{params[word]}")
      else

        # when normal parse
        "#{params[word]}"
      end

    end
  end

  def remove_curly_bracket(string)
    # regex remove { and }
    regex_remover = /[{}]/

    result = string.gsub(regex_remover, "")

    result
  end

  def base_url
    "https://api.airtable.com/v0/#{@base_id}/#{@table_name}"
  end

  def parse_body(response)
    JSON.parse(response.env['response_body'])
  end

end