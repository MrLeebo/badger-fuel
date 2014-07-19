Template.order_item.helpers
  in_edit_mode: ->
    @_id == Session.get "editing_order"

  order_class: ->
    switch @in
      when true then "success"
      when false then ""
      else "warning"

  status: ->
    switch @in
      when true then "In"
      when false then "Out"
      else ""

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
