require 'fastlane/action'

module Fastlane
  module Actions
    class BmcheckfornewdevicesAction < Action
      def self.run(params)
        app_information = params[:app_information]

        temp_firebase_testers_file = "~/tmp_testers_udis.txt"
        firebase_login_token = ENV["FIREBASE_LOGIN_TOKEN"]
        firebase_app_ids = [ENV["PRIVATE_FIREBASE_APP_ID_IOS_DEV"], ENV["PRIVATE_FIREBASE_APP_ID_IOS_PROD"]]

        firebase_app_ids.each do |firebase_app_id|
            
            if firebase_app_id.length > 1
                temp_firebase_testers_file = "tmp_testers"
                other_action.firebase_app_distribution_get_udids(
                    app: firebase_app_id, 
                    firebase_cli_token: firebase_login_token, 
                    output_file: temp_firebase_testers_file, 
                    debug: true
                )

                api_key = other_action.app_store_connect_api_key()
                other_action.register_devices(devices_file: temp_firebase_testers_file)

                sh("rm #{temp_firebase_testers_file}")            
            end
        end

        # Esto no entra en el .each anterior pq esto ya se hace tomando en cuenta la lista de bundle ids que hay en el arhcivo de match 
        # Es decir, al mometno de intentar un match development o match adhoc, el action de match ya usa todos los bundle que necsite segund el archivo de match

        private_certificates_type_list_with_coma = ENV["PRIVATE_IOS_CERTIFICATES_TYPE_ARRAY"]
        private_certificates_type_array = private_certificates_type_list_with_coma.split(",")
                  
        private_certificates_type_array.each do |certificate|
            other_action.match(type: certificate, force: true, verbose: true)
        end

        UI.message("Devices Added")
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
