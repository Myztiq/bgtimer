`import Ember from 'ember'`

Controller = Ember.Controller.extend
  actions:
    remove: (player)->
      player.set 'active', false
      player.set 'name', null


`export default Controller`
