require 'fastlane/action'

module Fastlane

  module Helper
    class BmDistribution

      def self.send_to_firebase(other_action, app_information, platform_type)
        version_info = Helper::BmHelper.version_func_get_version(platform_type:platform_type)
        fabric_build_number = version_info[:build_number]
    
        # set other information for fabric
        fabric_app_name = app_information[:app_name]
        fabric_changelogs_description = app_information[:changelog]
        fabric_notes = "Version #{fabric_build_number} from #{fabric_app_name} \n\n#{fabric_changelogs_description}"    
        fabric_groups = nil
        fabric_mails = nil
    
        # SEND VERSION
        fabric_groups = ""
        fabric_mails = ""
        firebase_app_id = ""
        if platform_type == Helper::BmHelper::CONST_PROJECT_TYPE__IOS
            if app_information[:environment] == Helper::BmHelper::CONST_PROJECT_ENVIRONMENT__PROD
                fabric_groups = ENV["PRIVATE_IOS_FABRIC_GROUPS_PROD"]
                fabric_mails = ENV["PRIVATE_IOS_FABRIC_MAILS_PROD"]
                firebase_app_id = ENV["PRIVATE_FIREBASE_APP_ID_IOS_PROD"]
            else 
                fabric_groups = ENV["PRIVATE_IOS_FABRIC_GROUPS_DEV"]
                fabric_mails = ENV["PRIVATE_IOS_FABRIC_MAILS_DEV"]
                firebase_app_id = ENV["PRIVATE_FIREBASE_APP_ID_IOS_DEV"]
            end 
        elsif
            if app_information[:environment] == Helper::BmHelper::CONST_PROJECT_ENVIRONMENT__PROD
                fabric_groups = ENV["PRIVATE_ANDROID_FABRIC_GROUPS_PROD"]
                fabric_mails = ENV["PRIVATE_ANDROID_FABRIC_MAILS_PROD"]
                firebase_app_id = ENV["PRIVATE_FIREBASE_APP_ID_ANDROID_PROD"]
            else 
                fabric_groups = ENV["PRIVATE_ANDROID_FABRIC_GROUPS_DEV"]
                fabric_mails = ENV["PRIVATE_ANDROID_FABRIC_MAILS_DEV"]
                firebase_app_id = ENV["PRIVATE_FIREBASE_APP_ID_ANDROID_DEV"]
            end
        end
    
        firebase_login_token = ENV["FIREBASE_LOGIN_TOKEN"]
        if fabric_groups.length > 0 && fabric_mails.length > 0
            other_action.firebase_app_distribution(app: firebase_app_id, firebase_cli_token: firebase_login_token, testers: fabric_mails, groups: fabric_groups, release_notes: fabric_notes, debug: true)
        elsif fabric_groups.length > 0
            other_action.firebase_app_distribution(app: firebase_app_id, firebase_cli_token: firebase_login_token, groups: fabric_groups, release_notes: fabric_notes, debug: true)
        elsif fabric_mails.length > 0
            other_action.firebase_app_distribution(app: firebase_app_id, firebase_cli_token: firebase_login_token, testers: fabric_mails, release_notes: fabric_notes, debug: true)
        else
            other_action.firebase_app_distribution(app: firebase_app_id, firebase_cli_token: firebase_login_token, release_notes: fabric_notes, debug: true)
        end
    
        other_action.bmslacknewversion(destiny: "Firebase", app_information: app_information, platform_type: platform_type)
      end

      def self.send_to_browserstack(other_action, app_information, platform_type, file_path)  

        new_file_path = ""
        version_info = Helper::BmHelper.version_func_get_version(platform_type:platform_type)

        if platform_type == Helper::BmHelper::CONST_PROJECT_TYPE__IOS
          ipa_location = file_path
          ipa_path = File.dirname(ipa_location)
          ipa_new_path = ipa_path + "/#{app_information[:app_name]}_#{app_information[:environment]}_#{version_info[:version_number]}_#{version_info[:build_number]}.ipa"
          File.rename(ipa_location, ipa_new_path)
          
          new_file_path = ipa_new_path
        end

        if platform_type == Helper::BmHelper::CONST_PROJECT_TYPE__ANDROID
          apk_location = file_path
          apk_path = File.dirname(apk_location)
          apk_new_path = apk_path + "/#{app_information[:app_name]}_#{app_information[:environment]}_#{version_info[:version_number]}_#{version_info[:build_number]}.apk"
          File.rename(apk_location, apk_new_path)

          new_file_path = apk_new_path
        end 

        other_action.upload_to_browserstack_app_live(
          browserstack_username: ENV["BROWSERSTACK_USERNAME"],
          browserstack_access_key: ENV["BROWSERSTACK_ACCESS_KEY"],
          file_path: new_file_path
        )
        #TODO: Hay que borrar el APK o IPA luego de que se envie? o esto lo va borrando solo el plugin?
        
        other_action.bmslacknewversion(destiny: "BrowserStack", app_information: app_information, platform_type: platform_type)
      end


      #TODO: NOT MIGRATED OR TESTED YET 
      def self.distribution_func_testflight(app_information)  
        version_info = Helper::BmHelper.version_func_get_version(platform_type:Helper::BmHelper::CONST_PROJECT_TYPE__IOS)
        testflight_notes = "Version #{version_info[:build_number]} from #{app_information[:app_name]} \n\n#{app_information[:changelog]}"
    
        testflight_groups = nil
        if app_information[:environment] == Helper::BmHelper::CONST_PROJECT_ENVIRONMENT__PROD
            testflight_groups = ENV["PRIVATE_FABRIC_GROUPS_PROD"]
        else 
            testflight_groups = ENV["PRIVATE_FABRIC_GROUPS_DEV"]
        end 
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