`import DS from 'ember-data'`

Game = DS.Model.extend
  name: DS.attr 'string'
  startTime: DS.attr 'number'
  paused: DS.attr 'boolean'

  isDemo: false
  players: DS.hasMany 'player'


Game.reopenClass
  FIXTURES: []

`export default Game`