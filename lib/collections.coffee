@Places = new Meteor.Collection "places"
@Orders = new Meteor.Collection "orders"
@Lunches = new Meteor.Collection "lunches"

@Places.allow
  insert: (uid, place) -> true
  update: (uid, place) -> true
  remove: (uid, place) -> true

@Orders.allow
  insert: (uid, place) -> true
  update: (uid, place) -> true
  remove: (uid, place) -> true
