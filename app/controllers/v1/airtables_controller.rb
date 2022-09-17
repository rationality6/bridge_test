class V1::AirtablesController < ApplicationController
  def copy
    AirtableServiceInstance.hello()
    render json: {}
  end

  def copy_with_key

    render json: { value: "foo" }
  end

  def refresh
    render json: {}
  end
end



