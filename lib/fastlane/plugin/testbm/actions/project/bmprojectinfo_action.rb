require 'fastlane/action'

module Fastlane
  module Actions
    class BmprojectinfoAction < Action
      def self.run(params)
        environment = params[:environment]
        Helper::BmProject::get_information(environment: environment)
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
                                       type: String)
        ]
      end

      def self.is_supported?(platform)
        true
      end

    end
  end
end
