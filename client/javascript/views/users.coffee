Template.users.users = ->
  Meteor.users.find "status.online": true

Template.user_pill.helpers
  online_since: ->
    @status.lastLogin.date

  labelClass: ->
    return "label-warning" if @status.idle
    return "label-success" if @status.online
    return "label-default"

Template.user_pill.rendered = ->
  @$(".label").tooltip()

Template.user_pill.events
  'mouseover .label': (evt) ->
    $el = $(evt.target)
    timestamp = new Date $el.data('ts')
    timeago = $.timeago(timestamp)
    newTitle = "Logged in #{timeago}"
    $el
      .attr('title', newTitle)
      .tooltip('fixTitle')
      .data('bs.tooltip')
      .$tip.find('.tooltip-inner')
      .text(newTitle)
