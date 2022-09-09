module Fastlane
    module Helper
        class BmVersion
            def self.get_version(project_information:, platform_type:)
                build_number = ""
                version_number = ""
            
                if platform_type == Helper::BmHelper::CONST_PROJECT_TYPE__IOS
                    version_number = get_info_plist_value(project_information: project_information, key: "CFBundleShortVersionString")
                    build_number = get_info_plist_value(project_information: project_information, key: "CFBundleVersion")
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

            def version_func_update_build_number_for_hibrid(app_information:)
                #TODO, pendiente de hacer
            end

            # Aqui hay que ver si vale la pena solo pasra el tipo de plataforma o otda la info. 
            def self.version_func_update_build_number(other_action:, project_information:, platform_type:)

                #check that the git is clean so the only change that is commited is the new version number
                other_action.ensure_git_status_clean()
                
                build_number = version_func_get_time_with_build_number_format() 
                
                if platform_type == Helper::BmHelper::CONST_PROJECT_TYPE__IOS
                    #versionNumber = get_info_plist_value(project_information: project_information, key: "CFBundleShortVersionString")
                    #buildNumber = get_info_plist_value(project_information: project_information, key: "CFBundleVersion")

                    #puts "######################## versionNumber: #{versionNumber} ############"
                    #puts "######################## buildNumber: #{buildNumber} ############"





                    #puts "######################## build_number: #{build_number} ############"
                    # TODO Falta hacer el build_numebr com en adnroid 

                    #this functions increment/set the version in all the schemas of the project
                    set_info_plist_value(project_information: project_information, key: "CFBundleVersion", value: build_number)
                    #set_info_plist_value(project_information:, ke
                    #increment_build_number(build_number: build_number)
                    #increment_version_number(bump_type: "patch")

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

                version_info = self.get_version(project_information: project_information, platform_type: platform_type)
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

            def self.version_func_get_time_with_build_number_format()
                time = Time.now.utc
                format_for_time = "%d%02d%02d%02d%02d"
                time_parts_to_format = [ time.year, time.month, time.day, time.hour, time.min ]
                time_with_format = format_for_time % time_parts_to_format
                return time_with_format[2..11]
            end

            def self.get_info_plist_value(project_information:, key:)
                begin
                    infoPlistPath = "./#{ENV['PRIVATE_APP_NAME']}/#{project_information.get_ios_info_plist_name}.plist"
                    path = File.expand_path(infoPlistPath)
            
                    plist = File.open(path) { |f| Plist.parse_xml(f) }
            
                    value = plist[key]
            
                    return value
                rescue => ex
                    UI.error(ex)
                end
            end

            def self.set_info_plist_value(project_information:, key:, value:)
                begin
                    infoPlistPath = "./#{ENV['PRIVATE_APP_NAME']}/#{project_information.get_ios_info_plist_name}.plist"
                    path = File.expand_path(infoPlistPath)
                    plist = Plist.parse_xml(path)

                    plist[key] = value
                    
                    new_plist = Plist::Emit.dump(plist)
                    
                    File.write(path, new_plist)
        
                    return value
                rescue => ex
                    UI.error(ex)
                    UI.user_error!("Unable to set value to plist file at '#{path}'")
                end
            end
        end
    end
  end
  