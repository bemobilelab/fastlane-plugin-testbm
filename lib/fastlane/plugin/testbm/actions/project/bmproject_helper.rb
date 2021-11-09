module Fastlane

  module Helper
    class BmProject

        def self.get_information(environment:, ios_sign_config_type: "") 

            #Get android info
            android_scheme_name = ENV["PRIVATE_ANDROID_SCHEME_NAME_DEV"]
            android_bundle_id = ENV["PRIVATE_ANDROID_APP_ID_DEV"]
            android_build_type = ENV["PRIVATE_ANDROID_BUILD_TYPE_DEV"]
            if environment == Helper::BmHelper::CONST_PROJECT_ENVIRONMENT__PROD
                android_scheme_name = ENV["PRIVATE_ANDROID_SCHEME_NAME_PROD"]
                android_bundle_id = ENV["PRIVATE_ANDROID_APP_ID_PROD"]
                android_build_type = ENV["PRIVATE_ANDROID_BUILD_TYPE_PROD"]
            end
        
            #Get ios scheme name
            ios_scheme_name = ENV["PRIVATE_IOS_SCHEME_NAME_DEV"]
            ios_bundle_id = ENV["PRIVATE_IOS_BUNDLE_ID_DEV"]
            if environment == Helper::BmHelper::CONST_PROJECT_ENVIRONMENT__PROD
                ios_scheme_name = ENV["PRIVATE_IOS_SCHEME_NAME_PROD"]
                ios_bundle_id = ENV["PRIVATE_IOS_BUNDLE_ID_PROD"]
            end
        
            information = {
                app_name: ENV["PRIVATE_APP_NAME"],
                environment: environment,
                changelog: ENV["PRIVATE_CHANGELOG"], 
        
                android: {
                    scheme_name: android_scheme_name,
                    bundle_id: android_bundle_id,
                    build_type: android_build_type, #DevRelease
                },
                ios: {
                    xcodeproj: ENV["PRIVATE_XCODEPROJ_NAME"],
                    workspace: ENV["PRIVATE_XCWORKSPACE_NAME"],
                    scheme_name: ios_scheme_name,
                    bundle_id: ios_bundle_id,
                    sign_config_type: ios_sign_config_type, # == match_type
                }
            }    
            information
          end

    end
  end
end
