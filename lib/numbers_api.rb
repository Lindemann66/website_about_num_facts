class NumbersApi
  RAND_NUMB_MAXIMUM = 50000
  NOT_FOUND_ROUND_OPT = "floor"
  MIN_OPT = 1
  MAX_OPT = 50000
  BATCH_OPT = "1..5,15"


  class << self
    def get_fragment
      logger.tagged(self.name, __method__) do
        url = uri_for(api_endpoint, {fragment: "true"})

        process_uri(url) do |response|
          url.to_s + ": " + response.body
        end
      end
    end

    def get_notfound
      logger.tagged(self.name, __method__) do
        url = uri_for(api_endpoint, {notfound: NOT_FOUND_ROUND_OPT})

        process_uri(url) do |response|
          url.to_s + ": " + response.body
        end
      end
    end

    def get_default
      logger.tagged(self.name, __method__) do
        url = uri_for(api_endpoint, {default: Settings.numbers_api.default_text})

        process_uri(url) do |response|
          url.to_s + ": " + response.body
        end
      end
    end

    def get_min_and_max
      logger.tagged(self.name, __method__) do
        url = uri_for(api_endpoint("random"), {min: MIN_OPT, max: MAX_OPT})

        process_uri(url) do |response|
          url.to_s + ": " + response.body
        end
      end
    end

    def get_batch_requests
      logger.tagged(self.name, __method__) do
        url = uri_for(api_endpoint(BATCH_OPT))

        process_uri(url) do |response|
          url.to_s + ": " + response.body
        end
      end
    end

    private

    def logger
      Rails.logger
    end

    def api_endpoint(subject = rand(RAND_NUMB_MAXIMUM))
      Settings.numbers_api.url % {subject: subject}
    end

    def uri_for(url, params = {})
      uri = URI(url)
      params["json"] = true
      uri.query = URI.encode_www_form(params)
      uri
    end

    def process_uri(uri)
      logger.info "send request to #{uri.to_s}"
      RestClient.get(uri.to_s) do |response, request, result|
        logger.info "response code & body: #{response.code} #{response.body}"

        yield response
      end
    rescue => e
      error_msg = "Error while executing request: #{e.message}"
      logger.error error_msg
      error_msg
    end
  end
end