`import Ember from 'ember'`

BluetoothController = Ember.Controller.extend
  init: ->
    @send 'enable'

  connectionStatus: null

  connected: Ember.computed.equal 'connectionStatus', 'connected'
  connecting: Ember.computed.equal 'connectionStatus', 'connecting'
  disconnected: Ember.computed.equal 'connectionStatus', 'disconnected'
  disconnecting: Ember.computed.equal 'connectionStatus', 'disconnecting'

  connectingObserver: (->
    if @get 'connecting'
      Ember.RSVP.denodiefy(blutoothle.stopScan).finally ->
        console.log 'Stopped scanning'
  ).observes 'connecting'

  connectedObserver: (->
    if @get 'connected'
      bluetoothle.services ((rtn)->
        console.log 'Got services'
        console.log JSON.stringify rtn, 0, 2
      ), (err)->
        console.log 'Error getting services'
        console.log JSON.stringify err, 0, 2
  ).observes 'connected'

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
        console.log 'Rtn', rtn
        console.log rtn.status
        if rtn.status == 'enabled'
          @set 'enabled', true
        else
          @set 'enabled', false
      ), (err)->
        console.log 'Initialization failure', err
      , request: true

    scan: ->
      bluetoothle.startScan ((rtn)=>
        if rtn.status == 'scanStarted'
          @set 'scanning', true
        else if rtn.status == 'scanResult'
          devices = @get 'devices'
          console.log "Found new device:", JSON.stringify(rtn)
          devices.pushObject
            address: rtn.address
            name: rtn.name
            rssi: rtn.rssi
      ), (err)->
        console.log 'Scan Failure'

    connect: (device)->
      console.log 'Connecting to ', JSON.stringify(device)

      bluetoothle.connect ((rtn)=>
        console.log 'Connect rtn: ', JSON.stringify rtn
        @set 'connectionStatus', rtn.status
      ), ((err)->
        console.log 'Error connecting', err
      ), address: device.address




`export default BluetoothController`