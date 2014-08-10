Meteor.startup ->
  Accounts.ui.config
    passwordSignupFields: 'EMAIL_ONLY'

orgCallback = Accounts.oauth.credentialRequestCompleteHandler
Accounts.oauth.credentialRequestCompleteHandler = (callback) ->
  (credentialTokenOrError) ->
    orgCallback(callback)(credentialTokenOrError)
    Router.go("home")
