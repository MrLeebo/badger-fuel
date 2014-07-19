Template.orders.helpers
  place_id: ->
    Session.get "place_id"

  in_insert_mode: ->
    "new" == Session.get "editing_order"

Template.orders.orders = (place_id) ->
  Orders.find(active: true, place_id: place_id)

$(document).click ->
  Session.set "editing_order", null

Template.orders.events
  'click form': (evt) ->
    evt.stopPropagation()

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
