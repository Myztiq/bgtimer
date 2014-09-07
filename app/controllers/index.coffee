`import Ember from 'ember'`
`import evothings from 'bgtimer/lib/evothings'`

IndexController = Ember.Controller.extend
  init: ->
    setTimeout =>
      @send 'scan'
    , 500


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
          @send 'connectedDevice', info.deviceHandle
          @set 'connectedDevice', info.deviceHandle
        else
          @send 'bluetoothDisconnected'

      ), ((err)->
        console.log 'Error connecting', err
      )

`export default IndexController`