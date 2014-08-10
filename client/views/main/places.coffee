Template.places.places = ->
  sort_order = Session.get("sort_order") || "asc"
  return _.shuffle(Places.find().fetch()) if sort_order == "shuffle"
  Places.find({},{sort: name: if sort_order == "asc" then 1 else -1})

Template.places.alpha_sort_active = ->
  sort_order = Session.get("sort_order") || "asc"
  if (sort_order in ["asc", "desc"]) then "active" else ""

Template.places.alpha_sort_glyph = ->
  if Session.get("sort_order") == "desc" then "glyphicon-sort-by-alphabet-alt" else "glyphicon-sort-by-alphabet"

Template.places.shuffle_sort_active = ->
  "active" if Session.get("sort_order") == "shuffle"

Template.places.events
  'click #alpha-sort': (e) ->
    e.preventDefault()
    sort_order = Session.get("sort_order") || "asc"
    Session.set("sort_order", if sort_order == "asc" then "desc" else "asc")

  'click #shuffle': (e) ->
    e.preventDefault()
    Session.set("sort_order", "")
    Session.set("sort_order", "shuffle")

  'click .btn-delete': (e) ->
    e.preventDefault()

    return unless confirm("Do you really want to get rid of #{@name}?")

    Session.set "place_id", null if Session.get("place_id") == @_id

    Places.update @_id, $set: active: false

  'click .place-item': (e) ->
    Session.set "place_id", @_id

Template.place_item.rendered = ->
  $(@firstNode).css(left: "-20px").animate({left: 0}, 300)

Template.place_item.helpers
  has_selection: ->
    "active" if @_id == Session.get "place_id"

Template.new_place_form.events
  'submit form': (e) ->
    e.preventDefault()

    form = e.target
    name = form.name.value.trim()

    if name
      Places.insert name: name, active: true
      form.reset()
