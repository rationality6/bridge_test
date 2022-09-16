class V1::AirtablesController < ApplicationController
  def copy
    render json: {}
  end

  def copy_with_key

    render json: { key: "foo" }
  end
end



