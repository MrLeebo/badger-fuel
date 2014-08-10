Template.order_item.helpers
  in_edit_mode: ->
    @_id == Session.get "editing_order"

  in_insert_mode: ->
    "new" == Session.get "editing_order"

  order_class: ->
    switch @status
      when "in" then "success"
      when "out" then ""
      when "out_forever" then ""
      else "warning"

  status: ->
    switch @status
      when "in" then "In"
      when "out" then "Out"
      when "out_forever" then "Out Forever"
      else ""

Template.order_item.events
  'click .btn-in': (evt) ->
    evt.preventDefault()
    evt.stopPropagation()
    Orders.update {_id: @_id}, {$set: status: "in"}

  'click .btn-out': (evt) ->
    evt.preventDefault()
    evt.stopPropagation()
    Orders.update {_id: @_id}, {$set: status: "out"}

  'click .btn-out-forever': (evt) ->
    evt.preventDefault()
    evt.stopPropagation()
    Orders.update {_id: @_id}, {$set: status: "out_forever"}

Template.order_item_edit.rendered = ->
  @find("input")?.focus()

Template.order_item_edit.events
  'click .btn-edit': (evt) ->
    evt.preventDefault()

    form = evt.currentTarget.form
    sets =
      name: form.name.value.trim()
      order: form.order.value.trim()
      mods: form.mods.value.trim()
      side: form.side.value.trim()

    Orders.update {_id: @_id}, {$set: sets}
    Session.set "editing_order", null
