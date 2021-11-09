require 'fastlane/action'

module Fastlane
  module Actions
    class BmversionincrementAction < Action
      def self.run(params)
        app_information = params[:app_information]
        platform_type = params[:platform_type]

        if platform_type == Helper::BmHelper::CONST_PROJECT_TYPE__IOS 
            puts "PENDING CODE"
        elsif
            Helper::BmVersion::increment_build_number_for_android(other_action, app_information)
        end
      end

      def self.description
        "TODO"
      end
      
      def self.authors
        ["Bemobile"]
      end

      def self.return_value
        "TODO. If your method provides a return value, you can describe here what it does"
      end

      def self.details
        "TODO"
      end

      def self.available_options
        [
            FastlaneCore::ConfigItem.new(key: :app_information,
                            env_name: "APP_INFORMATION",
                        description: "The app information including name, version",
                            optional: false,
                                type: Hash),
            FastlaneCore::ConfigItem.new(key: :platform_type,
                            env_name: "PLATFORM_TYPE",
                        description: "Indicates platform wheter android or ios",
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