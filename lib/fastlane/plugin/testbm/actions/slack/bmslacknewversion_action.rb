require 'fastlane/action'

#TODO: Missing the build and version numbers 
#TODO: Missing release notes... laso in firebase upload

module Fastlane
  module Actions
    class BmslacknewversionAction < Action
      def self.run(params)
        destiny = params[:destiny]
        project_information = params[:project_information]
        platform_type = params[:platform_type]
        
        message_text = ""

        payload = {
            "App Name" => project_information.get_app_name,
            "Platform" => platform_type,
            "Destiny" => destiny,
            "Build Date" => Time.new.to_s  
        }
        Helper::BmSlack::notify(other_action: other_action, message_text: message_text, payload: payload)
      end

      def self.description
        "Sends a message to a Slack chat specified in the SLACK_URL environment variable"
      end

      def self.authors
        ["Bemobile"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        "Sends a message to a Slack webhook. The message must be passed to the function as a parameter named message_text. 
         To specify that the message comes from an exception or not, we must pass the is_exception parameter.
         An icon must be specified as a param named slack_icon, or as an environment variable named SLACK_ICON.
         The webhook URL must be specified as an environment variable called SLACK_URL.
         The username which sends the message can be appendend with the environment variable called PRIVATE_APP_NAME."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :destiny,
                                   env_name: "DESTINY",
                                description: "The chat message to be sent to Slack",
                                   optional: false,
                                       type: String),
            FastlaneCore::ConfigItem.new(key: :project_information,
                                        env_name: "APP_INFORMATION",
                                     description: "The app information",
                                        optional: false,
                                            type: BmProjectInformation),
            FastlaneCore::ConfigItem.new(key: :platform_type,
                                    env_name: "PLATFORM_TYPE",
                                    description: "The platform, can be Android or iOS",
                                    optional: false,
                                        type: String)
        ]
      end

      def self.is_supported?(platform)
        true
      end

    end
  end
end
