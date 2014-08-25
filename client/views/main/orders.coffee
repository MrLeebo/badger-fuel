Template.orders.helpers
  place_id: ->
    Session.get "place_id"

  in_insert_mode: ->
    "new" == Session.get "editing_order"

Template.orders.orders = (place_id) ->
  Orders.find(place_id: place_id)

$(document).click ->
  Session.set "editing_order", null
  $('tr.order-item.active').removeClass("active")

Template.orders.events
  'click #clear-button': (evt) ->
    evt.preventDefault()
    Meteor.call("clear_orders", Session.get "place_id")

  'click form': (evt) ->
    evt.stopPropagation()

  'click .status-label': (evt) ->
    evt.stopPropagation()
    $(evt.target).closest('tr.order-item').addClass("active")

  'click .order-item': (evt) ->
    evt.preventDefault()
    Session.set "editing_order", @_id

  'click .new-order': (evt) ->
    evt.preventDefault()
    Session.set "editing_order", "new"

  'submit form': (evt) ->
    evt.preventDefault()

    form = evt.target
    order =
      name: form.name.value.trim()
      order: form.order.value.trim()
      mods: form.mods.value.trim()
      side: form.side.value.trim()
      place_id: Session.get "place_id"
      status: "in"
      active: true

    Orders.insert order
    Session.set "editing_order", null

    form.reset()

  'click .btn-delete': (evt) ->
    evt.preventDefault()

    return unless confirm("Do you really want to get rid of #{@name}'s order?")

    Orders.update @_id, $set: active: false

Template.order_item_insert.rendered = ->
  @find("input")?.focus()

Template.welcome.events
  'click #getStarted': (evt) ->
    evt.preventDefault()
    Session.set "place_id", Places.findOne({}, {sort: name: 1})._id
