`import Ember from 'ember'`

Router = Ember.Router.extend
  location: BgtimerENV.locationType

Router.map ->
  @route 'debug'
  @route '/'
  @route 'home'

  @resource 'game', {path: 'game/:game_id'}, ->
    @route 'pick-order'
    @resource 'player', ->
      @route 'edit', {path: ':player_id'}
      @route 'new'

`export default Router`
