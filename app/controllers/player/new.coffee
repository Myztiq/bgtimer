`import Ember from 'ember'`

Controller = Ember.ObjectController.extend
  needs: ['game']

  name: null

  bound: true # TODO - This should be false and we should listen for button presses

  # We want to listen to button presses by all unbound players. The first one to press the button first will get
  # bound to this player name.
  buttonPressed: (->
    @get('players').forEach (player)->
      if player.get('button')
        console.log 'Button pressed on player', player.get('id')
        @set 'bound', player

  ).observes 'players.@each.button'

  actions:
    save: ->
      bound = @get 'bound'
      if bound == true
        players = @get 'players'

        bound = players.findBy('active', false)
        if !bound
          console.log 'Could not find a free player. :('
          return
        bound.set 'active', true

      bound.set 'name', @get('name')
      @get('controllers.game.players').addObject(bound)
      @transitionToRoute 'game', @get 'controllers.game.model'


`export default Controller`
