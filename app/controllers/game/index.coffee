`import Ember from 'ember'`

Controller = Ember.ObjectController.extend
  actions:
    remove: (player)->
      player.set('active', false)
      @get('players').removeObject(player)

`export default Controller`
