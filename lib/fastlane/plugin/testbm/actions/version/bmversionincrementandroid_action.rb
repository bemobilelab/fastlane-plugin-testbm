require 'fastlane/action'

module Fastlane
  module Actions
    class BmversionincrementandroidAction < Action
      def self.run(params)
        project_information = params[:project_information]
        Helper::BmVersion::version_func_update_build_number(other_action: other_action, project_information: project_information, platform_type: Helper::BmHelper::CONST_PROJECT_TYPE__ANDROID)
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
            FastlaneCore::ConfigItem.new(key: :project_information,
                            env_name: "PROJECT_INFORMATION",
                        description: "The app information including name, version",
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