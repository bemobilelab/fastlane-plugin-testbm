require 'fastlane/action'

module Fastlane
  module Actions
    class SalutationAction < Action
      def self.run(params)
        UI.message("Hello World! #{Testbm::VERSION}" + )
      end

      def self.description
        "Returns hello world"
      end
      
      def self.authors
        ["Bemobile"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Just a test plugin"
      end

      def self.available_options
        []
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
