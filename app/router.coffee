`import Ember from 'ember'`

Router = Ember.Router.extend
  location: BgtimerENV.locationType

Router.map ->
  @route 'debug'
  @route 'bluetooth'

`export default Router`
