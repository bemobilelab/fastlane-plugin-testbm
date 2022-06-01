require 'fastlane/action'

module Fastlane
  module Actions
    class BmsendbrowserstackandroidAction < Action
      def self.run(params)
        project_information = params[:project_information]
        apk_location = "#{lane_context[SharedValues::GRADLE_APK_OUTPUT_PATH]}" 
        Helper::BmDistribution::send_to_browserstack(other_action, project_information, Helper::BmHelper::CONST_PROJECT_TYPE__ANDROID)  
        UI.message("Version distributed!")
      end

      def self.description
        "Distributes an app version via firebase, testflight, browsertack or the play store."
      end
      
      def self.authors
        ["Bemobile"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        "TODO"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :project_information,
                                   env_name: "APP_INFORMATION",
                                description: "The app information including name, version",
                                   optional: false,
                                       type: BmProjectInformation),
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
