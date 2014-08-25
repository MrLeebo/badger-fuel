Template.users.users = ->
  # Currently online or was logged in today
  midnight = new Date
  midnight.setHours(0,0,0,0)
  Meteor.users.find($or: [{'status.online': true}, {'status.lastLogin.date': $gte: midnight}])

Template.user_pill.helpers
  name: ->
    @profile.name || @profile.fullName || "#{@profile.firstName} #{@profile.lastName}"

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
