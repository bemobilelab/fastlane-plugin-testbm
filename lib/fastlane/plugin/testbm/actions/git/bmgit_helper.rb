require 'fastlane/action'

module Fastlane

  module Helper
    class BmGit

      #Get the changelog with defined params
      #The range of commit to search is from actual commit to
      #the last commit that has a build/ tag 
      def self.get_changelog(other_action)

        #https://git-scm.com/docs/pretty-formats
        #Example of actual format
        #- (891cde1) Mon, 4 Nov 2019 12:10:42 +0100 
        #Fix delete habit name
        #body text

        pretty_format = "- (%h) %aD \n%s\n%b"
        changelog = other_action.changelog_from_git_commits(
          pretty: pretty_format,
          date_format: "short",
          tag_match_pattern: "builds/*" # ESTO CREO QUE ES DIFERENTE PARA CADA PLATAFORMA "version/*" para android SE deberia unificar 
        )       
        return "\n#{changelog}"                                           
      end

    end
  end
end
