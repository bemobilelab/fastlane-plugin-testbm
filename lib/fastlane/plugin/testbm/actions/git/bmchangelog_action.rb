require 'fastlane/action'

module Fastlane
  module Actions
    class BmchangelogAction < Action
      def self.run(params)
        ENV["PRIVATE_CHANGELOG"] = Helper::BmGit::get_changelog(other_action)
      end

      def self.description
        "Save changelog in a ENV variable"
      end

      def self.authors
        ["Bemobile"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        #
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :person_name,
                                   env_name: "PERSON_NAME",
                                description: "The person's name",
                                   optional: false,
                                       type: String)
        ]# If your method provides a return value, you can describe here what it does
      end

      def self.is_supported?(platform)
        true
      end

    end
  end
end

