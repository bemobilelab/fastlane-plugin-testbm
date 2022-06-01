class BmProjectInformation
  def initialize()
    @environment = ""
    @flavor = ""
    @privateAppName = ""

    @privateFabricMails = ""
    @privateFabricGroups = ""

    @privateFirebaseId = ""
    @firebaseLoginToken = ""
    @crashlitycsApiToken = ""
    @crashlitycsBuildSecret = ""

    @iosSignConfigType = ""

    @browserstackUsername = ""
    @browserstackAccessKey = ""

  end

  def set_environment(environment)
    @environment = environment
  end

  def get_environment()
    @environment
  end

  def set_flavor(flavor)
    @flavor = flavor
  end

  def get_flavor()
    @flavor
  end

  def set_private_fabric_mails(privateFabricMails)
    @privateFabricMails = privateFabricMails
  end

  def get_private_fabric_mails()
    @privateFabricMails
  end

  def set_private_fabric_groups(privateFabricGroups)
    @privateFabricGroups = privateFabricGroups
  end

  def get_private_fabric_groups()
    @privateFabricGroups
  end

  def set_private_firebase_id(privateFirebaseId)
    @privateFirebaseId = privateFirebaseId
  end

  def get_private_firebase_id()
    @privateFirebaseId
  end

  def set_firebase_login_token(firebaseLoginToken)
    @firebaseLoginToken = firebaseLoginToken
  end

  def get_firebase_login_token()
    @firebaseLoginToken
  end

  def set_crashlitycs_api_token(crashlitycsApiToken)
    @crashlitycsApiToken = crashlitycsApiToken
  end

  def get_crashlitycs_api_token()
    @crashlitycsApiToken
  end

  def set_crashlitycs_build_secret(crashlitycsBuildSecret)
    @crashlitycsBuildSecret = crashlitycsBuildSecret
  end

  def get_crashlitycs_build_secret()
    @crashlitycsBuildSecret
  end
  def set_ios_sign_config_type(iosSignConfigType)
    @iosSignConfigType = iosSignConfigType
  end

  def get_ios_sign_config_type()
    @iosSignConfigType
  end

  def set_browserstack_username(browserstackUsername)
    @browserstackUsername = browserstackUsername
  end

  def get_browserstack_username()
    @browserstackUsername
  end

  def set_browserstack_access_key(browserstackAccessKey)
    @browserstackAccessKey = browserstackAccessKey
  end

  def get_browserstack_access_key()
    @browserstackAccessKey
  end
end