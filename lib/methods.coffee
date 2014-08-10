Meteor.methods
  reset_all: ->
    Places.remove {}
    Orders.remove {}
    Lunches.remove {}

  clear_orders: (place_id) ->
    Orders.update({place_id: place_id, status: {$in: ["in", "out"]}},{$set: {status: ""}})
