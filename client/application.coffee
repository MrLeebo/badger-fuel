Meteor.startup ->
  Accounts.ui.config
    passwordSignupFields: 'EMAIL_ONLY'

Meteor.subscribe("places")
Meteor.subscribe("orders")
Meteor.subscribe("users")

Deps.autorun (c) ->
  try # May be an error if time is not synced
    UserStatus.startMonitor
      threshold: 30000
      idleOnBlur: true
    c.stop()

orgCallback = Accounts.oauth.credentialRequestCompleteHandler
Accounts.oauth.credentialRequestCompleteHandler = (callback) ->
  (credentialTokenOrError) ->
    orgCallback(callback)(credentialTokenOrError)
    Router.go("index")
