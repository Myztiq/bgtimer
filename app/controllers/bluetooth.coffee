`import Ember from 'ember'`

BluetoothController = Ember.Controller.extend
  init: ->
    @send 'enable'

  connectionStatus: 'disconnected'

  connectedDevice: null

  connected:     Ember.computed.equal 'connectionStatus', 'connected'
  connecting:    Ember.computed.equal 'connectionStatus', 'connecting'
  disconnected:  Ember.computed.equal 'connectionStatus', 'disconnected'
  disconnecting: Ember.computed.equal 'connectionStatus', 'disconnecting'

  connectionStatusObserver: (->
    console.log 'Connection status changed: ', @get 'connectionStatus'
  ).observes 'connectionStatus'

  scanning: false

  connectingObserver: (->
    if ['connecting', 'connected'].indexOf @get('connectionStatus') >= 0
      if @get 'scanning'
        @set 'scanning', false
        bluetoothle.stopScan (->
          console.log 'Stopped scanning'
        ), (err)->
          console.log 'Error stopping scan', JSON.stringify err, 0, 2
  ).observes 'connectionStatus'

  connectedObserver: (->
    if @get 'connected'
      console.log 'Connected. Asking for services! Because why not?!'
      bluetoothle.services ((rtn)->
        console.log 'Got services'
        console.log JSON.stringify rtn, 0, 2
        if rtn.status == 'discoveredServices'
          for service in rtn.serviceUuids
            do (service)->
              console.log 'Getting characteristics for service', service
              bluetoothle.characteristics ((rtn)->
                console.log 'Got Characteristics for service', service
                console.log JSON.stringify rtn, 0, 2

                bluetoothle.subscribe ((dataUpdated)->
                  console.log dataUpdated.value
                  console.log atob dataUpdated.value
                ), (err)->
                  console.log 'Error subscribing to value', JSON.stringify err, 0, 2
                , {"serviceUuid":"fff0","characteristicUuid":"ff10"}
              ), ((err)->
                console.log 'Err getting characteristics', JSON.stringify err
              ), {serviceUuid: service}

      ), (err)->
        console.log 'Error getting services'
#        console.log JSON.stringify err, 0, 2
  ).observes 'connected'

  enabled: false
  enabledObserver: (->
    if @get 'enabled'
      @send 'scan'
  ).observes 'enabled'

  devices: []
  actions:
    enable: ->
      console.log 'Enabling Bluetooth'
      bluetoothle.initialize ((rtn)=>
        console.log 'Bluetooth Initialized', JSON.stringify rtn, 0, 2
        if rtn.status == 'enabled'
          @set 'enabled', true
        else
          @set 'enabled', false
      ), (err)->
        console.log 'Initialization failure', JSON.stringify err, 0, 2
      , request: true

    scan: ->
      bluetoothle.startScan ((rtn)=>
        if rtn.status == 'scanStarted'
          @set 'scanning', true
        else if rtn.status == 'scanResult'
          devices = @get 'devices'
          console.log "Found new device:", JSON.stringify(rtn, 0, 2)
          devices.pushObject
            address: rtn.address
            name: rtn.name
            rssi: rtn.rssi
      ), (err)->
        console.log 'Scan Failure', JSON.stringify err, 0, 2

    connect: (device)->
      console.log 'Connecting to device', JSON.stringify(device, 0, 2)

      bluetoothle.connect ((rtn)=>
        @set 'connectionStatus', rtn.status
      ), ((err)->
        console.log 'Error connecting', JSON.stringify err, 0, 2
      ), address: device.address




`export default BluetoothController`