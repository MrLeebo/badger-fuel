@get_ready_order_count = ->
  Orders.find({status: "in"}).count()

@get_waiting_order_count = ->
  Orders.find($or: [{status: $exists: false},{status: ''}]).count()

Template.nav.rendered = ->
  $('[title]').tooltip(container: "body", placement: "bottom")

Template.nav.ready_orders_count = ->
  get_ready_order_count()

Template.nav.waiting_orders_count = ->
  get_waiting_order_count()

Template.nav.places_count = ->
  Places.find({}).count()

Template.nav.user_name = ->
  Meteor.user()?.profile?.name || "Account"

Template.nav.current_label = ->
  setTimeout (->
    $('#current').tooltip('fixTitle')
    ), 0
  return "There is no active order in place. Click to start one!" unless Session.get("place_id")
  ready_orders = _("ready order").pluralize(get_ready_order_count(), true)
  waiting_orders = _("waiting order").pluralize(get_waiting_order_count(), true)
  current_place = Places.findOne({_id: Session.get("place_id")})
  "You have #{ready_orders} and #{waiting_orders} for #{current_place.name}"
