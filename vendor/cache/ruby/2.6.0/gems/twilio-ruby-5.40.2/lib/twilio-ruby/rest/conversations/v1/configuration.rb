##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Conversations < Domain
      class V1 < Version
        ##
        # PLEASE NOTE that this class contains beta products that are subject to change. Use them with caution.
        class ConfigurationList < ListResource
          ##
          # Initialize the ConfigurationList
          # @param [Version] version Version that contains the resource
          # @return [ConfigurationList] ConfigurationList
          def initialize(version)
            super(version)

            # Path Solution
            @solution = {}
          end

          ##
          # Provide a user friendly representation
          def to_s
            '#<Twilio.Conversations.V1.ConfigurationList>'
          end
        end

        ##
        # PLEASE NOTE that this class contains beta products that are subject to change. Use them with caution.
        class ConfigurationPage < Page
          ##
          # Initialize the ConfigurationPage
          # @param [Version] version Version that contains the resource
          # @param [Response] response Response from the API
          # @param [Hash] solution Path solution for the resource
          # @return [ConfigurationPage] ConfigurationPage
          def initialize(version, response, solution)
            super(version, response)

            # Path Solution
            @solution = solution
          end

          ##
          # Build an instance of ConfigurationInstance
          # @param [Hash] payload Payload response from the API
          # @return [ConfigurationInstance] ConfigurationInstance
          def get_instance(payload)
            ConfigurationInstance.new(@version, payload, )
          end

          ##
          # Provide a user friendly representation
          def to_s
            '<Twilio.Conversations.V1.ConfigurationPage>'
          end
        end

        ##
        # PLEASE NOTE that this class contains beta products that are subject to change. Use them with caution.
        class ConfigurationContext < InstanceContext
          ##
          # Initialize the ConfigurationContext
          # @param [Version] version Version that contains the resource
          # @return [ConfigurationContext] ConfigurationContext
          def initialize(version)
            super(version)

            # Path Solution
            @solution = {}
            @uri = "/Configuration"
          end

          ##
          # Fetch the ConfigurationInstance
          # @return [ConfigurationInstance] Fetched ConfigurationInstance
          def fetch
            payload = @version.fetch('GET', @uri)

            ConfigurationInstance.new(@version, payload, )
          end

          ##
          # Update the ConfigurationInstance
          # @param [String] default_chat_service_sid The SID of the default [Chat
          #   Service](https://www.twilio.com/docs/chat/rest/service-resource) to use when
          #   creating a conversation.
          # @param [String] default_messaging_service_sid The SID of the default [Messaging
          #   Service](https://www.twilio.com/docs/sms/services/api) to use when creating a
          #   conversation.
          # @param [String] default_inactive_timer Default ISO8601 duration when
          #   conversation will be switched to `inactive` state. Minimum value for this timer
          #   is 1 minute.
          # @param [String] default_closed_timer Default ISO8601 duration when conversation
          #   will be switched to `closed` state. Minimum value for this timer is 10 minutes.
          # @return [ConfigurationInstance] Updated ConfigurationInstance
          def update(default_chat_service_sid: :unset, default_messaging_service_sid: :unset, default_inactive_timer: :unset, default_closed_timer: :unset)
            data = Twilio::Values.of({
                'DefaultChatServiceSid' => default_chat_service_sid,
                'DefaultMessagingServiceSid' => default_messaging_service_sid,
                'DefaultInactiveTimer' => default_inactive_timer,
                'DefaultClosedTimer' => default_closed_timer,
            })

            payload = @version.update('POST', @uri, data: data)

            ConfigurationInstance.new(@version, payload, )
          end

          ##
          # Provide a user friendly representation
          def to_s
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.Conversations.V1.ConfigurationContext #{context}>"
          end

          ##
          # Provide a detailed, user friendly representation
          def inspect
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.Conversations.V1.ConfigurationContext #{context}>"
          end
        end

        ##
        # PLEASE NOTE that this class contains beta products that are subject to change. Use them with caution.
        class ConfigurationInstance < InstanceResource
          ##
          # Initialize the ConfigurationInstance
          # @param [Version] version Version that contains the resource
          # @param [Hash] payload payload that contains response from Twilio
          # @return [ConfigurationInstance] ConfigurationInstance
          def initialize(version, payload)
            super(version)

            # Marshaled Properties
            @properties = {
                'account_sid' => payload['account_sid'],
                'default_chat_service_sid' => payload['default_chat_service_sid'],
                'default_messaging_service_sid' => payload['default_messaging_service_sid'],
                'default_inactive_timer' => payload['default_inactive_timer'],
                'default_closed_timer' => payload['default_closed_timer'],
                'url' => payload['url'],
                'links' => payload['links'],
            }

            # Context
            @instance_context = nil
            @params = {}
          end

          ##
          # Generate an instance context for the instance, the context is capable of
          # performing various actions.  All instance actions are proxied to the context
          # @return [ConfigurationContext] ConfigurationContext for this ConfigurationInstance
          def context
            unless @instance_context
              @instance_context = ConfigurationContext.new(@version, )
            end
            @instance_context
          end

          ##
          # @return [String] The SID of the Account responsible for this configuration.
          def account_sid
            @properties['account_sid']
          end

          ##
          # @return [String] The SID of the default Chat Service that every new conversation is associated with.
          def default_chat_service_sid
            @properties['default_chat_service_sid']
          end

          ##
          # @return [String] The SID of the default Messaging Service that every new conversation is associated with.
          def default_messaging_service_sid
            @properties['default_messaging_service_sid']
          end

          ##
          # @return [String] Default ISO8601 duration when conversation will be switched to `inactive` state.
          def default_inactive_timer
            @properties['default_inactive_timer']
          end

          ##
          # @return [String] Default ISO8601 duration when conversation will be switched to `closed` state.
          def default_closed_timer
            @properties['default_closed_timer']
          end

          ##
          # @return [String] The url
          def url
            @properties['url']
          end

          ##
          # @return [String] The links
          def links
            @properties['links']
          end

          ##
          # Fetch the ConfigurationInstance
          # @return [ConfigurationInstance] Fetched ConfigurationInstance
          def fetch
            context.fetch
          end

          ##
          # Update the ConfigurationInstance
          # @param [String] default_chat_service_sid The SID of the default [Chat
          #   Service](https://www.twilio.com/docs/chat/rest/service-resource) to use when
          #   creating a conversation.
          # @param [String] default_messaging_service_sid The SID of the default [Messaging
          #   Service](https://www.twilio.com/docs/sms/services/api) to use when creating a
          #   conversation.
          # @param [String] default_inactive_timer Default ISO8601 duration when
          #   conversation will be switched to `inactive` state. Minimum value for this timer
          #   is 1 minute.
          # @param [String] default_closed_timer Default ISO8601 duration when conversation
          #   will be switched to `closed` state. Minimum value for this timer is 10 minutes.
          # @return [ConfigurationInstance] Updated ConfigurationInstance
          def update(default_chat_service_sid: :unset, default_messaging_service_sid: :unset, default_inactive_timer: :unset, default_closed_timer: :unset)
            context.update(
                default_chat_service_sid: default_chat_service_sid,
                default_messaging_service_sid: default_messaging_service_sid,
                default_inactive_timer: default_inactive_timer,
                default_closed_timer: default_closed_timer,
            )
          end

          ##
          # Provide a user friendly representation
          def to_s
            values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.Conversations.V1.ConfigurationInstance #{values}>"
          end

          ##
          # Provide a detailed, user friendly representation
          def inspect
            values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.Conversations.V1.ConfigurationInstance #{values}>"
          end
        end
      end
    end
  end
end