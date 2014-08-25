Meteor.startup ->
  # code to run on server at startup
  Meteor.publish 'users', ->
    midnight = new Date
    midnight.setHours(0,0,0,0)
    Meteor.users.find {$or: [{'status.online': true}, {'status.lastLogin.date': $gte: midnight}]}, {fields: {profile: 1, status: 1}}

  Meteor.publish 'places', ->
    Places.find {active: true}, {fields: name: 1, menu: 1}

  Meteor.publish 'orders', ->
    Orders.find {active: true}, {fields: {name: 1, order: 1, mods: 1, side: 1, status: 1, place_id: 1}}

  Meteor.publish 'lunches', ->
    Lunches.find {}
