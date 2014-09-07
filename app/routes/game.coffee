`import Ember from 'ember'`
`import evothings from 'bgtimer/lib/evothings'`

DebugRoute = Ember.Route.extend
  model: (params)->
    if params.game_id == 'new'
      @store.createRecord 'game'
    else
      @store.find('game', params.game_id)

  afterModel: (model)->
    model.set 'isDemo', evothings.isDemo

`export default DebugRoute`