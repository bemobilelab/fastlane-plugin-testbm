require 'fastlane/action'

module Fastlane
  module Actions
    class BmsendfirebaseandroidAction < Action
      def self.run(params)
        app_information = params[:app_information]
        Helper::BmDistribution::send_to_firebase(other_action, app_information, Helper::BmHelper::CONST_PROJECT_TYPE__ANDROID)  
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
          FastlaneCore::ConfigItem.new(key: :app_information,
                                   env_name: "APP_INFORMATION",
                                description: "The app information including name, version",
                                   optional: false,
                                       type: Hash)
        ]
      end

      def self.is_supported?(platform)
        true
      end

    end
  end
end
