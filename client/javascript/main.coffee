Template.nav.helpers
  places_count: ->
    Places.find(active: true).count()

  orders_count: ->
    Orders.find(active: true).count()

Template.welcome.events
  'click #getStarted': (evt) ->
    evt.preventDefault()
    Session.set "place_id", Places.findOne({active: true}, {sort: name: 1})._id
