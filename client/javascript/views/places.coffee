Template.places.places = ->
  Places.find({},{sort: name: 1})

Template.place_item.helpers
  has_selection: ->
    "active" if @_id == Session.get "place_id"

Template.places.events
  'click .btn-delete': (evt) ->
    evt.preventDefault()

    return unless confirm("Do you really want to get rid of #{@name}?")

    Session.set "place_id", null if Session.get("place_id") == @_id

    Places.update @_id, $set: active: false

  'click .place-item': (evt) ->
    Session.set "place_id", @_id

Template.new_place_form.events
  'submit form': (evt) ->
    evt.preventDefault()

    form = evt.target
    name = form.name.value.trim()

    if name
      Places.insert name: name, active: true
      form.reset()
