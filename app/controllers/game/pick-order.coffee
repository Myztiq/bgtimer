`import Ember from 'ember'`

Controller = Ember.ObjectController.extend
  needs: ['game']
  init: ->
    @get('players').forEach (player)->
      player.set 'hasPressed', false

  players: Ember.computed.alias 'controllers.game.players'

  nonPressedPlayers: Ember.computed.filterBy 'players', 'hasPressed', false
  orderSet: Ember.computed.empty 'nonPressedPlayers'

  actions:
    start: ->
      console.log 'START GAME! FUCK YES.'

`export default Controller`
