`import Ember from 'ember'`

AppRoute = Ember.Route.extend
  bluetoothConnection: false

  bluetoothObserver: (->
    if @get 'bluetoothConnection'
      @transitionTo 'home'
    else
      @transitionTo 'index'

  ).observes 'bluetoothConnection'

  connectedDevice: null

  connectedObserver: (->
    connectedDevice = @get 'connectedDevice'
    if connectedDevice
      console.log 'Connected! Now to read all service data...'
      evothings.ble.readAllServiceData connectedDevice, ((serviceData)=>
        console.log 'Got Service Data. Good luck trying to figure out where to put shit now!'
        console.log "Don't let the UUID's fool you, ignore the leading 0's and anything after the -'s and you have what you are looking for!"
        console.log JSON.stringify serviceData, 0, 2

        for service in serviceData
          do (service)=>
            realId = service.uuid.split('-')[0].toString().slice(4)
            if realId[0] == '1' # We are working with a player controller
              playerId = realId[1]
              @store.find('player', playerId).then (player)->
                player.set 'serviceHandle', service.handle
                player.set 'deviceHandle', connectedDevice

                for characteristic in service.characteristics
                  do (characteristic)->
                    realId = characteristic.uuid.split('-')[0].toString().slice(4)
                    if realId[0] == '2' # We are working with a characteristic
                      switch realId[3]
                        when '1'
                          console.log 'set buttonCharacteristicHandle',  characteristic.handle
                          player.set 'buttonCharacteristicHandle', characteristic.handle
                        when '2'
                          console.log 'set ledCharacteristicHandle',  characteristic.handle
                          player.set 'ledCharacteristicHandle', characteristic.handle
                        else
                          console.log 'I have no idea what this characteristic is for', realId[3]
              , (err)->
                console.log "Unable to find player #{playerId}", err
        @set 'bluetoothConnection', true
      ), (err)->
        console.log 'Error getting service data', err
  ).observes 'connectedDevice'

  actions:
    willTransition: (transition)->
      if !@get('bluetoothConnection') and transition.targetName != 'index'
        @transitionTo 'index'

    bluetoothDisconnected: (status)->
      @set 'bluetoothConnection', false

    connectedDevice: (deviceHandle)->
      @set 'connectedDevice', deviceHandle


`export default AppRoute`