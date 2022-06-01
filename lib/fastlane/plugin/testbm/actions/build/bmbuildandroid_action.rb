require 'fastlane/action'

module Fastlane
  module Actions
    class BmbuildandroidAction < Action
      def self.run(params)
        project_information = params[:project_information]
        other_action.gradle(task:"assemble", build_type: project_information.get_environment || "Debug", flavor: project_information.get_flavor)
        UI.message("Version built!")
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
          FastlaneCore::ConfigItem.new(key: :project_information,
                                   env_name: "PROJECT_INFORMATION",
                                description: "The project information",
                                   optional: false,
                                       type: BmProjectInformation)
        ]
      end

      def self.is_supported?(platform)
        true
      end

    end
  end
end
