require 'fastlane/action'

module Fastlane
  module Actions
    class BmversionAction < Action
      def self.run(params)
        platform_type = params[:platform_type]
        Helper::BmVersion::get_version(platform_type)
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
