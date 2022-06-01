require 'fastlane/action'

module Fastlane

  module Helper
    class BmDistribution

      def self.send_to_firebase(other_action, project_information, platform_type)
        version_info = Helper::BmHelper.version_func_get_version(platform_type:platform_type)
        fabric_build_number = version_info[:build_number]
    
        # set other information for fabric
        fabric_app_name = ENV["PRIVATE_APP_NAME"]
        fabric_changelogs_description = ENV["PRIVATE_CHANGELOG"]
        fabric_notes = "Version #{fabric_build_number} from #{fabric_app_name} \n\n#{fabric_changelogs_description}"    
        fabric_groups = nil
        fabric_mails = nil
    
        # SEND VERSION
        fabric_groups = project_information.get_private_fabric_groups
        fabric_mails = project_information.get_private_fabric_mails
        firebase_app_id = project_information.get_private_firebase_id
    
        firebase_login_token = project_information.get_firebase_login_token
        if fabric_groups.length > 0 && fabric_mails.length > 0
            other_action.firebase_app_distribution(app: firebase_app_id, firebase_cli_token: firebase_login_token, testers: fabric_mails, groups: fabric_groups, release_notes: fabric_notes, debug: true)
        elsif fabric_groups.length > 0
            other_action.firebase_app_distribution(app: firebase_app_id, firebase_cli_token: firebase_login_token, groups: fabric_groups, release_notes: fabric_notes, debug: true)
        elsif fabric_mails.length > 0
            other_action.firebase_app_distribution(app: firebase_app_id, firebase_cli_token: firebase_login_token, testers: fabric_mails, release_notes: fabric_notes, debug: true)
        else
            other_action.firebase_app_distribution(app: firebase_app_id, firebase_cli_token: firebase_login_token, release_notes: fabric_notes, debug: true)
        end
    
        other_action.bmslacknewversion(destiny: "Firebase", project_information: project_information, platform_type: platform_type)
      end

      def self.send_to_browserstack(other_action, project_information, platform_type, file_path)  

        version_info = Helper::BmHelper.version_func_get_version(platform_type:platform_type)
        version_extension = ".apk"

        if platform_type == Helper::BmHelper::CONST_PROJECT_TYPE__IOS
          version_extension = ".ipa"
        end 

        version_location = file_path
        version_path = File.dirname(version_location)
        version_new_path = version_path + "/#{project_information.get_app_name}_#{project_information.get_environment}_#{version_info[:version_number]}_#{version_info[:build_number]}#{version_extension}"
        File.rename(version_location, version_new_path)


        other_action.upload_to_browserstack_app_live(
          browserstack_username: project_information.get_browserstack_username,
          browserstack_access_key: project_information.get_browserstack_access_key,
          file_path: version_file_path
        )
        #TODO: Hay que borrar el APK o IPA luego de que se envie? o esto lo va borrando solo el plugin?
        
        other_action.bmslacknewversion(destiny: "BrowserStack", project_information: project_information, platform_type: platform_type)
      end


      #TODO: NOT MIGRATED OR TESTED YET 
      def self.distribution_func_testflight(project_information)  
        version_info = Helper::BmHelper.version_func_get_version(platform_type:Helper::BmHelper::CONST_PROJECT_TYPE__IOS)
        testflight_notes = "Version #{version_info[:build_number]} from #{project_information.get_app_name} \n\n#{app_information[:changelog]}"
    
        testflight_groups = nil
        testflight_groups = project_information.get_private_fabric_groups

        testflight_groups = testflight_groups.split(",")
    
        # upload to Testflight
        other_action.pilot(
            changelog: testflight_notes,
            skip_submission: false,
            skip_waiting_for_build_processing: true,
            distribute_external: true,
            app_identifier: version_info[:ios][:bundle_id],
            groups: testflight_groups)
        
        message_text = "#{app_information[:app_name]} App successfully released to TestFlight!"
        other_action.bmslack(message_text: message_text)                                        
      end
      
      #TODO: NOT MIGRATED OR TESTED YET 
      def self.distribution_func_itunes_connect(app_information)  
        other_action.appstore(force: true, skip_screenshots: true)
        message_text = "#{app_information[:app_name]} App successfully uploaded to Itunes Connect!"
        other_action.bmslack(message_text: message_text)     
      end


    end
  end
end