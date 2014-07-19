Meteor.methods
  reset_all: ->
    Places.remove {}
    Orders.remove {}
    People.remove {}
    Lunches.remove {}
