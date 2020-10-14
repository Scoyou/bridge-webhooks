##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Voice < Domain
      class V1 < Version
        class DialingPermissionsList < ListResource
          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class CountryList < ListResource
            ##
            # Initialize the CountryList
            # @param [Version] version Version that contains the resource
            # @return [CountryList] CountryList
            def initialize(version)
              super(version)

              # Path Solution
              @solution = {}
              @uri = "/DialingPermissions/Countries"
            end

            ##
            # Lists CountryInstance records from the API as a list.
            # Unlike stream(), this operation is eager and will load `limit` records into
            # memory before returning.
            # @param [String] iso_code Filter to retrieve the country permissions by
            #   specifying the [ISO country
            #   code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
            # @param [String] continent Filter to retrieve the country permissions by
            #   specifying the continent
            # @param [String] country_code Filter the results by specified [country
            #   codes](https://www.itu.int/itudoc/itu-t/ob-lists/icc/e164_763.html)
            # @param [Boolean] low_risk_numbers_enabled Filter to retrieve the country
            #   permissions with dialing to low-risk numbers enabled. Can be: `true` or `false`.
            # @param [Boolean] high_risk_special_numbers_enabled Filter to retrieve the
            #   country permissions with dialing to high-risk special service numbers enabled.
            #   Can be: `true` or `false`
            # @param [Boolean] high_risk_tollfraud_numbers_enabled Filter to retrieve the
            #   country permissions with dialing to high-risk [toll
            #   fraud](https://www.twilio.com/learn/voice-and-video/toll-fraud) numbers enabled.
            #   Can be: `true` or `false`.
            # @param [Integer] limit Upper limit for the number of records to return. stream()
            #    guarantees to never return more than limit.  Default is no limit
            # @param [Integer] page_size Number of records to fetch per request, when
            #    not set will use the default value of 50 records.  If no page_size is defined
            #    but a limit is defined, stream() will attempt to read the limit with the most
            #    efficient page size, i.e. min(limit, 1000)
            # @return [Array] Array of up to limit results
            def list(iso_code: :unset, continent: :unset, country_code: :unset, low_risk_numbers_enabled: :unset, high_risk_special_numbers_enabled: :unset, high_risk_tollfraud_numbers_enabled: :unset, limit: nil, page_size: nil)
              self.stream(
                  iso_code: iso_code,
                  continent: continent,
                  country_code: country_code,
                  low_risk_numbers_enabled: low_risk_numbers_enabled,
                  high_risk_special_numbers_enabled: high_risk_special_numbers_enabled,
                  high_risk_tollfraud_numbers_enabled: high_risk_tollfraud_numbers_enabled,
                  limit: limit,
                  page_size: page_size
              ).entries
            end

            ##
            # Streams CountryInstance records from the API as an Enumerable.
            # This operation lazily loads records as efficiently as possible until the limit
            # is reached.
            # @param [String] iso_code Filter to retrieve the country permissions by
            #   specifying the [ISO country
            #   code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
            # @param [String] continent Filter to retrieve the country permissions by
            #   specifying the continent
            # @param [String] country_code Filter the results by specified [country
            #   codes](https://www.itu.int/itudoc/itu-t/ob-lists/icc/e164_763.html)
            # @param [Boolean] low_risk_numbers_enabled Filter to retrieve the country
            #   permissions with dialing to low-risk numbers enabled. Can be: `true` or `false`.
            # @param [Boolean] high_risk_special_numbers_enabled Filter to retrieve the
            #   country permissions with dialing to high-risk special service numbers enabled.
            #   Can be: `true` or `false`
            # @param [Boolean] high_risk_tollfraud_numbers_enabled Filter to retrieve the
            #   country permissions with dialing to high-risk [toll
            #   fraud](https://www.twilio.com/learn/voice-and-video/toll-fraud) numbers enabled.
            #   Can be: `true` or `false`.
            # @param [Integer] limit Upper limit for the number of records to return. stream()
            #    guarantees to never return more than limit. Default is no limit.
            # @param [Integer] page_size Number of records to fetch per request, when
            #    not set will use the default value of 50 records. If no page_size is defined
            #    but a limit is defined, stream() will attempt to read the limit with the most
            #    efficient page size, i.e. min(limit, 1000)
            # @return [Enumerable] Enumerable that will yield up to limit results
            def stream(iso_code: :unset, continent: :unset, country_code: :unset, low_risk_numbers_enabled: :unset, high_risk_special_numbers_enabled: :unset, high_risk_tollfraud_numbers_enabled: :unset, limit: nil, page_size: nil)
              limits = @version.read_limits(limit, page_size)

              page = self.page(
                  iso_code: iso_code,
                  continent: continent,
                  country_code: country_code,
                  low_risk_numbers_enabled: low_risk_numbers_enabled,
                  high_risk_special_numbers_enabled: high_risk_special_numbers_enabled,
                  high_risk_tollfraud_numbers_enabled: high_risk_tollfraud_numbers_enabled,
                  page_size: limits[:page_size],
              )

              @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
            end

            ##
            # When passed a block, yields CountryInstance records from the API.
            # This operation lazily loads records as efficiently as possible until the limit
            # is reached.
            def each
              limits = @version.read_limits

              page = self.page(page_size: limits[:page_size], )

              @version.stream(page,
                              limit: limits[:limit],
                              page_limit: limits[:page_limit]).each {|x| yield x}
            end

            ##
            # Retrieve a single page of CountryInstance records from the API.
            # Request is executed immediately.
            # @param [String] iso_code Filter to retrieve the country permissions by
            #   specifying the [ISO country
            #   code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
            # @param [String] continent Filter to retrieve the country permissions by
            #   specifying the continent
            # @param [String] country_code Filter the results by specified [country
            #   codes](https://www.itu.int/itudoc/itu-t/ob-lists/icc/e164_763.html)
            # @param [Boolean] low_risk_numbers_enabled Filter to retrieve the country
            #   permissions with dialing to low-risk numbers enabled. Can be: `true` or `false`.
            # @param [Boolean] high_risk_special_numbers_enabled Filter to retrieve the
            #   country permissions with dialing to high-risk special service numbers enabled.
            #   Can be: `true` or `false`
            # @param [Boolean] high_risk_tollfraud_numbers_enabled Filter to retrieve the
            #   country permissions with dialing to high-risk [toll
            #   fraud](https://www.twilio.com/learn/voice-and-video/toll-fraud) numbers enabled.
            #   Can be: `true` or `false`.
            # @param [String] page_token PageToken provided by the API
            # @param [Integer] page_number Page Number, this value is simply for client state
            # @param [Integer] page_size Number of records to return, defaults to 50
            # @return [Page] Page of CountryInstance
            def page(iso_code: :unset, continent: :unset, country_code: :unset, low_risk_numbers_enabled: :unset, high_risk_special_numbers_enabled: :unset, high_risk_tollfraud_numbers_enabled: :unset, page_token: :unset, page_number: :unset, page_size: :unset)
              params = Twilio::Values.of({
                  'IsoCode' => iso_code,
                  'Continent' => continent,
                  'CountryCode' => country_code,
                  'LowRiskNumbersEnabled' => low_risk_numbers_enabled,
                  'HighRiskSpecialNumbersEnabled' => high_risk_special_numbers_enabled,
                  'HighRiskTollfraudNumbersEnabled' => high_risk_tollfraud_numbers_enabled,
                  'PageToken' => page_token,
                  'Page' => page_number,
                  'PageSize' => page_size,
              })

              response = @version.page('GET', @uri, params: params)

              CountryPage.new(@version, response, @solution)
            end

            ##
            # Retrieve a single page of CountryInstance records from the API.
            # Request is executed immediately.
            # @param [String] target_url API-generated URL for the requested results page
            # @return [Page] Page of CountryInstance
            def get_page(target_url)
              response = @version.domain.request(
                  'GET',
                  target_url
              )
              CountryPage.new(@version, response, @solution)
            end

            ##
            # Provide a user friendly representation
            def to_s
              '#<Twilio.Voice.V1.CountryList>'
            end
          end

          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class CountryPage < Page
            ##
            # Initialize the CountryPage
            # @param [Version] version Version that contains the resource
            # @param [Response] response Response from the API
            # @param [Hash] solution Path solution for the resource
            # @return [CountryPage] CountryPage
            def initialize(version, response, solution)
              super(version, response)

              # Path Solution
              @solution = solution
            end

            ##
            # Build an instance of CountryInstance
            # @param [Hash] payload Payload response from the API
            # @return [CountryInstance] CountryInstance
            def get_instance(payload)
              CountryInstance.new(@version, payload, )
            end

            ##
            # Provide a user friendly representation
            def to_s
              '<Twilio.Voice.V1.CountryPage>'
            end
          end

          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class CountryContext < InstanceContext
            ##
            # Initialize the CountryContext
            # @param [Version] version Version that contains the resource
            # @param [String] iso_code The [ISO country
            #   code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of the
            #   DialingPermissions Country resource to fetch
            # @return [CountryContext] CountryContext
            def initialize(version, iso_code)
              super(version)

              # Path Solution
              @solution = {iso_code: iso_code, }
              @uri = "/DialingPermissions/Countries/#{@solution[:iso_code]}"

              # Dependents
              @highrisk_special_prefixes = nil
            end

            ##
            # Fetch the CountryInstance
            # @return [CountryInstance] Fetched CountryInstance
            def fetch
              payload = @version.fetch('GET', @uri)

              CountryInstance.new(@version, payload, iso_code: @solution[:iso_code], )
            end

            ##
            # Access the highrisk_special_prefixes
            # @return [HighriskSpecialPrefixList]
            # @return [HighriskSpecialPrefixContext]
            def highrisk_special_prefixes
              unless @highrisk_special_prefixes
                @highrisk_special_prefixes = HighriskSpecialPrefixList.new(@version, iso_code: @solution[:iso_code], )
              end

              @highrisk_special_prefixes
            end

            ##
            # Provide a user friendly representation
            def to_s
              context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
              "#<Twilio.Voice.V1.CountryContext #{context}>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
              "#<Twilio.Voice.V1.CountryContext #{context}>"
            end
          end

          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class CountryInstance < InstanceResource
            ##
            # Initialize the CountryInstance
            # @param [Version] version Version that contains the resource
            # @param [Hash] payload payload that contains response from Twilio
            # @param [String] iso_code The [ISO country
            #   code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of the
            #   DialingPermissions Country resource to fetch
            # @return [CountryInstance] CountryInstance
            def initialize(version, payload, iso_code: nil)
              super(version)

              # Marshaled Properties
              @properties = {
                  'iso_code' => payload['iso_code'],
                  'name' => payload['name'],
                  'continent' => payload['continent'],
                  'country_codes' => payload['country_codes'],
                  'low_risk_numbers_enabled' => payload['low_risk_numbers_enabled'],
                  'high_risk_special_numbers_enabled' => payload['high_risk_special_numbers_enabled'],
                  'high_risk_tollfraud_numbers_enabled' => payload['high_risk_tollfraud_numbers_enabled'],
                  'url' => payload['url'],
                  'links' => payload['links'],
              }

              # Context
              @instance_context = nil
              @params = {'iso_code' => iso_code || @properties['iso_code'], }
            end

            ##
            # Generate an instance context for the instance, the context is capable of
            # performing various actions.  All instance actions are proxied to the context
            # @return [CountryContext] CountryContext for this CountryInstance
            def context
              unless @instance_context
                @instance_context = CountryContext.new(@version, @params['iso_code'], )
              end
              @instance_context
            end

            ##
            # @return [String] The ISO country code
            def iso_code
              @properties['iso_code']
            end

            ##
            # @return [String] The name of the country
            def name
              @properties['name']
            end

            ##
            # @return [String] The name of the continent in which the country is located
            def continent
              @properties['continent']
            end

            ##
            # @return [String] The E.164 assigned country codes(s)
            def country_codes
              @properties['country_codes']
            end

            ##
            # @return [Boolean] Whether dialing to low-risk numbers is enabled
            def low_risk_numbers_enabled
              @properties['low_risk_numbers_enabled']
            end

            ##
            # @return [Boolean] Whether dialing to high-risk special services numbers is enabled
            def high_risk_special_numbers_enabled
              @properties['high_risk_special_numbers_enabled']
            end

            ##
            # @return [Boolean] Whether dialing to high-risk toll fraud numbers is enabled, else `false`
            def high_risk_tollfraud_numbers_enabled
              @properties['high_risk_tollfraud_numbers_enabled']
            end

            ##
            # @return [String] The absolute URL of this resource
            def url
              @properties['url']
            end

            ##
            # @return [String] A list of URLs related to this resource
            def links
              @properties['links']
            end

            ##
            # Fetch the CountryInstance
            # @return [CountryInstance] Fetched CountryInstance
            def fetch
              context.fetch
            end

            ##
            # Access the highrisk_special_prefixes
            # @return [highrisk_special_prefixes] highrisk_special_prefixes
            def highrisk_special_prefixes
              context.highrisk_special_prefixes
            end

            ##
            # Provide a user friendly representation
            def to_s
              values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
              "<Twilio.Voice.V1.CountryInstance #{values}>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
              "<Twilio.Voice.V1.CountryInstance #{values}>"
            end
          end
        end
      end
    end
  end
end