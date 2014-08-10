Meteor.subscribe("places")
Meteor.subscribe("orders")
Meteor.subscribe("users")

Deps.autorun (c) ->
  try # May be an error if time is not synced
    UserStatus.startMonitor
      threshold: 30000
      idleOnBlur: true
    c.stop()
