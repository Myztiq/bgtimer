`import Ember from 'ember'`

DebugRoute = Ember.Route.extend
  model: (params)->
    if params.game_id == 'new'
      @store.createRecord 'game'
    else
      @store.find('game', params.game_id)

`export default DebugRoute`