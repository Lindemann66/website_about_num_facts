class NumberFactsController < ApplicationController
  def index
    @fragment = NumbersApi.get_fragment
    @notfound = NumbersApi.get_notfound
    @default = NumbersApi.get_default
    @min_and_max = NumbersApi.get_min_and_max
    @batch_requests = NumbersApi.get_batch_requests
  end
end
