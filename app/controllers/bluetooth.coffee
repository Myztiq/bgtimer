`import Ember from 'ember'`

BluetoothController = Ember.Controller.extend
  init: ->
    @send 'enable'

  connectionStatus: 'disconnected'

  connected:     Ember.computed.equal 'connectionStatus', 'connected'
  connecting:    Ember.computed.equal 'connectionStatus', 'connecting'
  disconnected:  Ember.computed.equal 'connectionStatus', 'disconnected'
  disconnecting: Ember.computed.equal 'connectionStatus', 'disconnecting'

  asdf: (->
    console.log "cantConnect: ", @get 'cantConnect'
  ).observes 'cantConnect'

  connectionStatusObserver: (->
    console.log 'Connection status changed: ', @get 'connectionStatus'
  ).observes 'connectionStatus'

  connectingObserver: (->
    console.log 'Connecting changed', @get 'connecting'
    if @get 'connecting'
      blutoothle.stopScan (->
        console.log 'Stopped scanning'
      ), (err)->
        console.log 'Error stopping scan', JSON.stringify err, 0, 2
  ).observes 'connecting'

#  connectedObserver: (->
#    if @get 'connected'
#      console.log 'Connected. Asking for services! Because why not?!'
#      bluetoothle.services ((rtn)->
#        console.log 'Got services'
#        console.log JSON.stringify rtn, 0, 2
#      ), (err)->
#        console.log 'Error getting services'
#        console.log JSON.stringify err, 0, 2
#  ).observes 'connected'

  enabled: false
  enabledObserver: (->
    if @get 'enabled'
      @send 'scan'
  ).observes 'enabled'

  devices: []
  scanning: false
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