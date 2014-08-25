Template.current_place.is_editing_menu = ->
  Session.get("editing_menu")?

Template.current_place.selected = ->
  Session.get("place_id")?

Template.current_place.name = ->
  Places.findOne({_id: Session.get("place_id")}).name

Template.current_place.menu = ->
  menu = Places.findOne({_id: Session.get("place_id")}).menu
  return menu if /\:\/\//.test menu
  "http://#{menu}" if menu

$(document).click ->
  Session.set "editing_menu", null

Template.current_place.events
  'click form': (evt) ->
    evt.stopPropagation()

  'click #menu-link': (evt) ->
    evt.preventDefault()
    place_id = Session.get "place_id"
    Session.set "editing_menu", place_id
    Meteor.defer -> @$('#menu').focus()

  'submit form': (evt) ->
    evt.preventDefault()

    form = evt.target
    menu = form.menu.value.trim()
    Places.update {_id: Session.get "place_id"}, {$set: menu: menu}
    Session.set "editing_menu", null
