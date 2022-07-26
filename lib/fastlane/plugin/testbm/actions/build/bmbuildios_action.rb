require 'fastlane/action'

module Fastlane
  module Actions
    class BmbuildiosAction < Action
      def self.run(params)
        project_information = params[:project_information]

        other_action.cocoapods(try_repo_update_on_error: true)

        other_action.match(
            type: project_information.get_ios_sign_config_type, 
            readonly: true, 
            clone_branch_directly: true, 
            verbose: true)

        export_method = Helper::BmBuild::get_correct_export_method_name(match_type: project_information.get_ios_sign_config_type)

        other_action.gym(
            scheme: project_information.get_ios_scheme,
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
