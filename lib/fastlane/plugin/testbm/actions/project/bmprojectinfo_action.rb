require 'fastlane/action'

module Fastlane
  module Actions
    class BmprojectinfoAction < Action
      def self.run(params)
        environment = params[:environment]
        ios_sign_config_type = params[:ios_sign_config_type] || ""
        Helper::BmProject::get_information(environment: environment, ios_sign_config_type: ios_sign_config_type)
      end

      def self.description
        "TODO"
      end

      def self.authors
        ["Bemobile"]
      end

      def self.return_value
        "TODO # If your method provides a return value, you can describe here what it does"
      end

      def self.details
        "TODO"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :environment,
                                   env_name: "ENVIRONMENT",
                                description: "The execution environment",
                                   optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :ios_sign_config_type,
                                  env_name: "IOS_SIGN_CONFIG_TYPE",
                                description: "The ios sign typ",
                                  optional: true,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        true
      end

    end
  end
end
