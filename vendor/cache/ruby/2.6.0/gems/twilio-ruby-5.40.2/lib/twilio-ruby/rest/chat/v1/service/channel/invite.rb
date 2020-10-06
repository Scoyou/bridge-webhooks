##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Chat < Domain
      class V1 < Version
        class ServiceContext < InstanceContext
          class ChannelContext < InstanceContext
            class InviteList < ListResource
              ##
              # Initialize the InviteList
              # @param [Version] version Version that contains the resource
              # @param [String] service_sid The SID of the
              #   [Service](https://www.twilio.com/docs/api/chat/rest/services) the resource is
              #   associated with.
              # @param [String] channel_sid The SID of the
              #   [Channel](https://www.twilio.com/docs/api/chat/rest/channels) the resource
              #   belongs to.
              # @return [InviteList] InviteList
              def initialize(version, service_sid: nil, channel_sid: nil)
                super(version)

                # Path Solution
                @solution = {service_sid: service_sid, channel_sid: channel_sid}
                @uri = "/Services/#{@solution[:service_sid]}/Channels/#{@solution[:channel_sid]}/Invites"
              end

              ##
              # Create the InviteInstance
              # @param [String] identity The `identity` value that uniquely identifies the new
              #   resource's [User](https://www.twilio.com/docs/api/chat/rest/v1/user) within the
              #   [Service](https://www.twilio.com/docs/api/chat/rest/v1/service). See [access
              #   tokens](https://www.twilio.com/docs/api/chat/guides/create-tokens) for more
              #   info.
              # @param [String] role_sid The SID of the
              #   [Role](https://www.twilio.com/docs/api/chat/rest/roles) assigned to the new
              #   member.
              # @return [InviteInstance] Created InviteInstance
              def create(identity: nil, role_sid: :unset)
                data = Twilio::Values.of({'Identity' => identity, 'RoleSid' => role_sid, })

                payload = @version.create('POST', @uri, data: data)

                InviteInstance.new(
                    @version,
                    payload,
                    service_sid: @solution[:service_sid],
                    channel_sid: @solution[:channel_sid],
                )
              end

              ##
              # Lists InviteInstance records from the API as a list.
              # Unlike stream(), this operation is eager and will load `limit` records into
              # memory before returning.
              # @param [String] identity The
              #   [User](https://www.twilio.com/docs/api/chat/rest/v1/user)'s `identity` value of
              #   the resources to read. See [access
              #   tokens](https://www.twilio.com/docs/api/chat/guides/create-tokens) for more
              #   details.
              # @param [Integer] limit Upper limit for the number of records to return. stream()
              #    guarantees to never return more than limit.  Default is no limit
              # @param [Integer] page_size Number of records to fetch per request, when
              #    not set will use the default value of 50 records.  If no page_size is defined
              #    but a limit is defined, stream() will attempt to read the limit with the most
              #    efficient page size, i.e. min(limit, 1000)
              # @return [Array] Array of up to limit results
              def list(identity: :unset, limit: nil, page_size: nil)
                self.stream(identity: identity, limit: limit, page_size: page_size).entries
              end

              ##
              # Streams InviteInstance records from the API as an Enumerable.
              # This operation lazily loads records as efficiently as possible until the limit
              # is reached.
              # @param [String] identity The
              #   [User](https://www.twilio.com/docs/api/chat/rest/v1/user)'s `identity` value of
              #   the resources to read. See [access
              #   tokens](https://www.twilio.com/docs/api/chat/guides/create-tokens) for more
              #   details.
              # @param [Integer] limit Upper limit for the number of records to return. stream()
              #    guarantees to never return more than limit. Default is no limit.
              # @param [Integer] page_size Number of records to fetch per request, when
              #    not set will use the default value of 50 records. If no page_size is defined
              #    but a limit is defined, stream() will attempt to read the limit with the most
              #    efficient page size, i.e. min(limit, 1000)
              # @return [Enumerable] Enumerable that will yield up to limit results
              def stream(identity: :unset, limit: nil, page_size: nil)
                limits = @version.read_limits(limit, page_size)

                page = self.page(identity: identity, page_size: limits[:page_size], )

                @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
              end

              ##
              # When passed a block, yields InviteInstance records from the API.
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
              # Retrieve a single page of InviteInstance records from the API.
              # Request is executed immediately.
              # @param [String] identity The
              #   [User](https://www.twilio.com/docs/api/chat/rest/v1/user)'s `identity` value of
              #   the resources to read. See [access
              #   tokens](https://www.twilio.com/docs/api/chat/guides/create-tokens) for more
              #   details.
              # @param [String] page_token PageToken provided by the API
              # @param [Integer] page_number Page Number, this value is simply for client state
              # @param [Integer] page_size Number of records to return, defaults to 50
              # @return [Page] Page of InviteInstance
              def page(identity: :unset, page_token: :unset, page_number: :unset, page_size: :unset)
                params = Twilio::Values.of({
                    'Identity' => Twilio.serialize_list(identity) { |e| e },
                    'PageToken' => page_token,
                    'Page' => page_number,
                    'PageSize' => page_size,
                })

                response = @version.page('GET', @uri, params: params)

                InvitePage.new(@version, response, @solution)
              end

              ##
              # Retrieve a single page of InviteInstance records from the API.
              # Request is executed immediately.
              # @param [String] target_url API-generated URL for the requested results page
              # @return [Page] Page of InviteInstance
              def get_page(target_url)
                response = @version.domain.request(
                    'GET',
                    target_url
                )
                InvitePage.new(@version, response, @solution)
              end

              ##
              # Provide a user friendly representation
              def to_s
                '#<Twilio.Chat.V1.InviteList>'
              end
            end

            class InvitePage < Page
              ##
              # Initialize the InvitePage
              # @param [Version] version Version that contains the resource
              # @param [Response] response Response from the API
              # @param [Hash] solution Path solution for the resource
              # @return [InvitePage] InvitePage
              def initialize(version, response, solution)
                super(version, response)

                # Path Solution
                @solution = solution
              end

              ##
              # Build an instance of InviteInstance
              # @param [Hash] payload Payload response from the API
              # @return [InviteInstance] InviteInstance
              def get_instance(payload)
                InviteInstance.new(
                    @version,
                    payload,
                    service_sid: @solution[:service_sid],
                    channel_sid: @solution[:channel_sid],
                )
              end

              ##
              # Provide a user friendly representation
              def to_s
                '<Twilio.Chat.V1.InvitePage>'
              end
            end

            class InviteContext < InstanceContext
              ##
              # Initialize the InviteContext
              # @param [Version] version Version that contains the resource
              # @param [String] service_sid The SID of the
              #   [Service](https://www.twilio.com/docs/api/chat/rest/services) to fetch the
              #   resource from.
              # @param [String] channel_sid The SID of the
              #   [Channel](https://www.twilio.com/docs/api/chat/rest/channels) the resource to
              #   fetch belongs to.
              # @param [String] sid The Twilio-provided string that uniquely identifies the
              #   Invite resource to fetch.
              # @return [InviteContext] InviteContext
              def initialize(version, service_sid, channel_sid, sid)
                super(version)

                # Path Solution
                @solution = {service_sid: service_sid, channel_sid: channel_sid, sid: sid, }
                @uri = "/Services/#{@solution[:service_sid]}/Channels/#{@solution[:channel_sid]}/Invites/#{@solution[:sid]}"
              end

              ##
              # Fetch the InviteInstance
              # @return [InviteInstance] Fetched InviteInstance
              def fetch
                payload = @version.fetch('GET', @uri)

                InviteInstance.new(
                    @version,
                    payload,
                    service_sid: @solution[:service_sid],
                    channel_sid: @solution[:channel_sid],
                    sid: @solution[:sid],
                )
              end

              ##
              # Delete the InviteInstance
              # @return [Boolean] true if delete succeeds, false otherwise
              def delete
                 @version.delete('DELETE', @uri)
              end

              ##
              # Provide a user friendly representation
              def to_s
                context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
                "#<Twilio.Chat.V1.InviteContext #{context}>"
              end

              ##
              # Provide a detailed, user friendly representation
              def inspect
                context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
                "#<Twilio.Chat.V1.InviteContext #{context}>"
              end
            end

            class InviteInstance < InstanceResource
              ##
              # Initialize the InviteInstance
              # @param [Version] version Version that contains the resource
              # @param [Hash] payload payload that contains response from Twilio
              # @param [String] service_sid The SID of the
              #   [Service](https://www.twilio.com/docs/api/chat/rest/services) the resource is
              #   associated with.
              # @param [String] channel_sid The SID of the
              #   [Channel](https://www.twilio.com/docs/api/chat/rest/channels) the resource
              #   belongs to.
              # @param [String] sid The Twilio-provided string that uniquely identifies the
              #   Invite resource to fetch.
              # @return [InviteInstance] InviteInstance
              def initialize(version, payload, service_sid: nil, channel_sid: nil, sid: nil)
                super(version)

                # Marshaled Properties
                @properties = {
                    'sid' => payload['sid'],
                    'account_sid' => payload['account_sid'],
                    'channel_sid' => payload['channel_sid'],
                    'service_sid' => payload['service_sid'],
                    'identity' => payload['identity'],
                    'date_created' => Twilio.deserialize_iso8601_datetime(payload['date_created']),
                    'date_updated' => Twilio.deserialize_iso8601_datetime(payload['date_updated']),
                    'role_sid' => payload['role_sid'],
                    'created_by' => payload['created_by'],
                    'url' => payload['url'],
                }

                # Context
                @instance_context = nil
                @params = {
                    'service_sid' => service_sid,
                    'channel_sid' => channel_sid,
                    'sid' => sid || @properties['sid'],
                }
              end

              ##
              # Generate an instance context for the instance, the context is capable of
              # performing various actions.  All instance actions are proxied to the context
              # @return [InviteContext] InviteContext for this InviteInstance
              def context
                unless @instance_context
                  @instance_context = InviteContext.new(
                      @version,
                      @params['service_sid'],
                      @params['channel_sid'],
                      @params['sid'],
                  )
                end
                @instance_context
              end

              ##
              # @return [String] The unique string that identifies the resource
              def sid
                @properties['sid']
              end

              ##
              # @return [String] The SID of the Account that created the resource
              def account_sid
                @properties['account_sid']
              end

              ##
              # @return [String] The SID of the Channel the new resource belongs to
              def channel_sid
                @properties['channel_sid']
              end

              ##
              # @return [String] The SID of the Service that the resource is associated with
              def service_sid
                @properties['service_sid']
              end

              ##
              # @return [String] The string that identifies the resource's User
              def identity
                @properties['identity']
              end

              ##
              # @return [Time] The RFC 2822 date and time in GMT when the resource was created
              def date_created
                @properties['date_created']
              end

              ##
              # @return [Time] The RFC 2822 date and time in GMT when the resource was last updated
              def date_updated
                @properties['date_updated']
              end

              ##
              # @return [String] The SID of the Role assigned to the member
              def role_sid
                @properties['role_sid']
              end

              ##
              # @return [String] The identity of the User that created the invite
              def created_by
                @properties['created_by']
              end

              ##
              # @return [String] The absolute URL of the Invite resource
              def url
                @properties['url']
              end

              ##
              # Fetch the InviteInstance
              # @return [InviteInstance] Fetched InviteInstance
              def fetch
                context.fetch
              end

              ##
              # Delete the InviteInstance
              # @return [Boolean] true if delete succeeds, false otherwise
              def delete
                context.delete
              end

              ##
              # Provide a user friendly representation
              def to_s
                values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                "<Twilio.Chat.V1.InviteInstance #{values}>"
              end

              ##
              # Provide a detailed, user friendly representation
              def inspect
                values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
                "<Twilio.Chat.V1.InviteInstance #{values}>"
              end
            end
          end
        end
      end
    end
  end
end