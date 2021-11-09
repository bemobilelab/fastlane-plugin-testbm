module Fastlane

    module Helper
      class BmSlack
        
        def self.notify(other_action:, message_text:, payload: )
            other_action.slack(
                message: message_text,
                success: true,
                default_payloads: [:lane, :git_branch, :git_author],
                icon_url: ENV["SLACK_ICON"],
                username: "Bemobile Fastlane Plugin - #{ENV["PRIVATE_APP_NAME"]}", 
                payload: payload)
          end
    
        #Notify an error of the lane and show the error that fastlane has
        def self.notify_error_in_lane(other_action, exception)
            payload = {
                "Build Date" => Time.new.to_s,
                "Error Message" => exception.message
            }
    
            other_action.slack(
                message: "#{ENV["PRIVATE_APP_NAME"]} App build stop with error",
                success: false,
                default_payloads: [:lane, :git_branch, :git_author],
                icon_url: ENV["SLACK_ICON"],
                username: "Bemobile Fastlane Plugin - #{ENV["PRIVATE_APP_NAME"]}",
                payload: payload)
    
          end
    
      end
    end
  end
  