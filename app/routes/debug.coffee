`import Ember from 'ember'`

DebugRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      players: @store.find('player')

  actions:
    toggleButton: (player)->
      player.set 'button', true

`export default DebugRoute`