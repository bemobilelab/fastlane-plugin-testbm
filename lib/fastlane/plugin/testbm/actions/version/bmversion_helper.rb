module Fastlane
    module Helper
        class BmVersion

            def self.get_version(platform_type)
                build_number = ""
                version_number = ""
            
                if platform_type == Helper::BmHelper::CONST_PROJECT_TYPE__IOS
                    version_number = Actions.lane_context[Actions::SharedValues::VERSION_NUMBER]
                    build_number = Actions.lane_context[Actions::SharedValues::BUILD_NUMBER]
                elsif
                    version_number = File.read("version.name").to_s  
                    build_number = File.read("version.number").to_s  
                end
            
                {build_number: build_number, version_number: version_number}
            end



            #Increment the build number and the version number, then makes a commit and push to git with a tag
            #The build number is set with the date and hour 
            #The version number is incremented in the patch part by 0.0.1
            #The push is made to the current working branch


            def self.increment_build_number_for_android(other_action, app_information)
                self.version_func_update_build_number(other_action: other_action, app_information: app_information, platform_type: Helper::BmHelper::CONST_PROJECT_TYPE__ANDROID)
            end

            def version_func_update_build_number_for_ios(app_information:)
                version_func_update_build_number(app_information: app_information, platform_type: CONST_PROJECT_TYPE__IOS)
            end

            def version_func_update_build_number_for_hibrid(app_information:)
                #TODO, pendiente de hacer
            end

            # Aqui hay que ver si vale la pena solo pasra el tipo de plataforma o otda la info. 
            def self.version_func_update_build_number(other_action:, app_information:, platform_type:)

                #check that the git is clean so the only change that is commited is the new version number
                other_action.ensure_git_status_clean()
                
                #build_number = version_func_get_time_with_build_number_format() 
                
                if platform_type == Helper::BmHelper::CONST_PROJECT_TYPE__IOS
                    # TODO Falta hacer el build_numebr com en adnroid 

                    #this functions increment/set the version in all the schemas of the project
                    increment_build_number(build_number: build_number, xcodeproj: app_information[:ios][:xcodeproj])
                    increment_version_number(bump_type: "patch")

                elsif 

                    build_number = File.read("version.number").to_i
                    build_number = build_number + 1

                    version_name = File.read("version.name").to_s  
                    parts = version_name.split('.')
                    part_patch = parts[2].to_i
                    part_patch = part_patch + 1
                    parts[2] = part_patch.to_s
                    version_name = parts.join('.')

                    #set the new version in the files so the gradle can read it
                    File.write("version.name", version_name)
                    File.write("version.number", build_number)
                end

                version_info = self.get_version(platform_type:platform_type)
                final_version_number = version_info[:version_number]
                final_build_number = version_info[:build_number]


                message = "Build from fastlane #{final_build_number} #{final_version_number}"
                complet_git_message = "#{message}. [skip ci]"


                if platform_type == Helper::BmHelper::CONST_PROJECT_TYPE__IOS
                    commit_version_bump(message: complet_git_message) #[skip ci] makes that de ci ignores this push
                    #Hay que ver que tag pone y si puede poner un tag igual para nadorid y opara ios 
                    add_git_tag
                elsif   
                    other_action.git_commit( path: [ "./version.name", "./version.number" ], message: complet_git_message)        
                    other_action.add_git_tag(tag: "builds/#{final_version_number}/#{final_build_number}")
                end

                actual_branch_name = other_action.git_branch
                puts "Branch #{actual_branch_name}"
                other_action.push_to_git_remote(local_branch: "HEAD", remote_branch: actual_branch_name)
                
            end
  
        end
    end
  end
  