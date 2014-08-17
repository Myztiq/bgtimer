`import Ember from 'ember'`

DebugRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      players: @store.find('player')


`export default DebugRoute`