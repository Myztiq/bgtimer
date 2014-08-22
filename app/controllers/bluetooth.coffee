`import Ember from 'ember'`

BluetoothController = Ember.Controller.extend
  init: ->
    @send 'scan'

  connectionStatus: 'STATE_DISCONNECTED'

  connectedDevice: null

  connected:     Ember.computed.equal 'connectionStatus', 'STATE_CONNECTED'
  connecting:    Ember.computed.equal 'connectionStatus', 'STATE_CONNECTING'
  disconnected:  Ember.computed.equal 'connectionStatus', 'STATE_DISCONNECTED'
  disconnecting: Ember.computed.equal 'connectionStatus', 'STATE_DISCONNECTING'

  scanning: false

  connectingObserver: (->
    connected = @get 'connected'
    connecting = @get 'connecting'
    scanning = @get 'scanning'
    if (connected or connecting) and scanning
      console.log 'Stopping scanning!'
      @set 'scanning', false
      evothings.ble.stopScan (->
        console.log 'Stopped scanning'
      ), (err)->
        console.log 'Error stopping scan', err
  ).observes 'connected', 'connecting', 'scanning'

  connectedObserver: (->
    connectedDevice = @get 'connectedDevice'
    connected = @get 'connected'
    if connected and connectedDevice
      console.log 'Connected! Now to read all service data...'
      evothings.ble.readAllServiceData connectedDevice, ((serviceData)->
        console.log 'Got Service Data. Good luck trying to figure out where to put shit now!'
        console.log "Don't let the UUID's fool you, ignore the leading 0's and anything after the -'s and you have what you are looking for!"
        console.log JSON.stringify serviceData, 0, 2
      ), (err)->
        console.log 'Error getting service data', err
  ).observes 'connected', 'connectedDevice'

  devices: []
  actions:
    scan: ->
      @set 'devices', []
      @set 'scanning', true
      devices = @get 'devices'
      evothings.ble.startScan ((rtn)=>
        device = devices.findBy 'address', rtn.address
        if device?
          device.setProperties rtn
        else
          devices.pushObject Ember.Object.create rtn
      ), (err)->
        console.log 'Scan Failure', err

    connect: (device)->
      evothings.ble.connect device.address, ((info)=>
        state = evothings.ble.connectionState[info.state]
        console.log 'Updated connection state', state
        @set 'connectionStatus', state
        console.log 'Connection status updated'

        if state == 'STATE_CONNECTED'
          console.log 'Connected', info.deviceHandle
          @set 'connectedDevice', info.deviceHandle

      ), ((err)->
        console.log 'Error connecting', err
      )

`export default BluetoothController`