class V1::AirtablesController < ApplicationController
  def copy
    render json: AirtableServiceInstance.json_data
  end

  def copy_with_key
    raise "Empty key error" unless params['key'].present?

    result_value = AirtableServiceInstance.parse_value_by_key(params)
    render json: { value: result_value }
  end

  def copy_with_key_created_at
    params['key'] = 'intro.created_at'
    result_value = AirtableServiceInstance.parse_value_by_key(params)
    render json: { value: result_value }
  end

  def copy_with_key_updated_at
    params['key'] = 'intro.updated_at'
    result_value = AirtableServiceInstance.parse_value_by_key(params)
    render json: { value: result_value }
  end

  def refresh
    AirtableServiceInstance.get_airtable_data
    render json: AirtableServiceInstance.json_data
  end
end



