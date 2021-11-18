require 'fastlane/action'

module Fastlane
  module Actions
    class BmbuildiosAction < Action
      def self.run(params)
        app_information = params[:app_information]

        other_action.cocoapods(try_repo_update_on_error: true)

        other_action.match(
            type: app_information[:ios][:sign_config_type], 
            readonly: true, 
            clone_branch_directly: true, 
            verbose: true)

        export_method = Helper::BmBuild::get_correct_export_method_name(match_type: app_information[:ios][:sign_config_type])

        other_action.gym(
            scheme: app_information[:ios][:scheme_name],
            export_method: export_method,
            include_symbols: true,
            include_bitcode: true,
            output_name: "CompiledApp")

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
          FastlaneCore::ConfigItem.new(key: :app_information,
                                   env_name: "APP_INFORMATION",
                                description: "The app information",
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
