`import DS from 'ember-data'`

Player = DS.Model.extend
  name: DS.attr 'string'

  active: false
  hasPressed: false

  _led: null
  led: ((key, val)->
    if val?
      @set '_led', val
      @set 'hasPressed', true

      console.log 'Setting led to', val
      evothings.ble.writeCharacteristic(
        @get('deviceHandle'),
        @get('ledCharacteristicHandle'),
        evothings.ble.toUtf8(val),
        (->), (err)->
          console.log 'Update Failure', err
      )

    @get '_led'
  ).property('_led')

  _button: null
  button: ((key, val)->
    if val?
      @set '_button', val
      console.log 'Setting button to', val
      evothings.ble.writeCharacteristic(
        @get('deviceHandle'),
        @get('buttonCharacteristicHandle'),
        evothings.ble.toUtf8(val),
        ( ->), (err)->
          console.log 'Update Failure', err
      )
    @get '_button'
  ).property()

  buttonCharacteristicHandle: null
  ledCharacteristicHandle: null
  serviceHandle: null
  deviceHandle: null

  buttonCharacteristicWatcher: (->
    buttonCharacteristicHandle = @get('buttonCharacteristicHandle')
    deviceHandle = @get 'deviceHandle'
    serviceHandle = @get('serviceHandle')
    if buttonCharacteristicHandle? and serviceHandle? and deviceHandle?
      console.log 'Setting up button!'
      evothings.ble.enableNotification(
        deviceHandle,
        buttonCharacteristicHandle,
        ((newVal)=>
          newVal = evothings.ble.fromUtf8(newVal)
          if newVal == 'true'
            @set '_button', true
          else
            @set '_button', false
        ), (err)->
          console.log 'Error subscribing to button status', err
      )

  ).observes 'buttonCharacteristicHandle', 'serviceHandle', 'deviceHandle'

  ledCharacteristicWatcher: (->
    ledCharacteristicHandle = @get('ledCharacteristicHandle')
    deviceHandle = @get 'deviceHandle'
    serviceHandle = @get('serviceHandle')
    if ledCharacteristicHandle? and serviceHandle? and deviceHandle?
      console.log 'Setting up LED!'
      evothings.ble.enableNotification(
        deviceHandle,
        ledCharacteristicHandle,
        ((newVal)=>
          newVal = evothings.ble.fromUtf8(newVal)
          if newVal == 'true'
            @set '_led', true
          else
            @set '_led', false

        ), (err)->
          console.log 'Error subscribing to LED status', err
      )


  ).observes 'ledCharacteristicHandle', 'serviceHandle', 'deviceHandle'


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