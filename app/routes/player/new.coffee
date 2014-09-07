`import Ember from 'ember'`

Route = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      players: @store.find('player')

`export default Route`