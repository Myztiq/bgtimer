`import DS from 'ember-data'`

Player = DS.Model.extend
  name: DS.attr 'string'
  led: DS.attr 'boolean'
  button: DS.attr 'boolean'

Player.reopenClass
  FIXTURES: [
    { id: 1, led: false, button: false }
    { id: 2, led: false, button: false }
    { id: 3, led: false, button: false }
    { id: 4, led: false, button: false }
    { id: 5, led: false, button: false }
    { id: 6, led: false, button: false }
  ]

`export default Player`