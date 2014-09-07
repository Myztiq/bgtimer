foo =
  ble:
    connectionState:
      0: 'STATE_DISCONNECTED'
      1: 'STATE_CONNECTING'
      2: 'STATE_CONNECTED'
      3: 'STATE_DISCONNECTING'

    stopScan: ->
    startScan: (cb)->
      for i in [0..3]
        cb
          address: Math.random()
          name: 'Device '+i
    connect: (device, cb)->
      console.log 'Connecting to ', device

      setTimeout ->
        cb({state: 1, deviceHandle: "deviceHandle"})

        setTimeout ->
          cb({state: 2, deviceHandle: "deviceHandle"})
        , 1000
      , 1000

    readAllServiceData: (deviceHandle, cb)->
      cb [
        {
          "handle": 2,
          "type": 0,
          "uuid": "00001100-0000-1000-8000-00805f9b34fb",
          "characteristics": [
            {
              "uuid": "00002101-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 20,
              "permission": 0,
              "handle": 8,
              "descriptors": [
                {
                  "handle": 20,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 21,
                  "permission": 0,
                  "uuid": "00002111-0000-1000-8000-00805f9b34fb"
                }
              ]
            },
            {
              "uuid": "00002102-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 30,
              "permission": 17,
              "handle": 9,
              "descriptors": [
                {
                  "handle": 22,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 23,
                  "permission": 0,
                  "uuid": "00002112-0000-1000-8000-00805f9b34fb"
                }
              ]
            }
          ]
        },
        {
          "handle": 3,
          "type": 0,
          "uuid": "00001200-0000-1000-8000-00805f9b34fb",
          "characteristics": [
            {
              "uuid": "00002201-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 20,
              "permission": 0,
              "handle": 10,
              "descriptors": [
                {
                  "handle": 24,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 25,
                  "permission": 0,
                  "uuid": "00002211-0000-1000-8000-00805f9b34fb"
                }
              ]
            },
            {
              "uuid": "00002202-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 30,
              "permission": 17,
              "handle": 11,
              "descriptors": [
                {
                  "handle": 26,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 27,
                  "permission": 0,
                  "uuid": "00002212-0000-1000-8000-00805f9b34fb"
                }
              ]
            }
          ]
        },
        {
          "handle": 4,
          "type": 0,
          "uuid": "00001300-0000-1000-8000-00805f9b34fb",
          "characteristics": [
            {
              "uuid": "00002301-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 20,
              "permission": 0,
              "handle": 12,
              "descriptors": [
                {
                  "handle": 28,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 29,
                  "permission": 0,
                  "uuid": "00002311-0000-1000-8000-00805f9b34fb"
                }
              ]
            },
            {
              "uuid": "00002302-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 30,
              "permission": 17,
              "handle": 13,
              "descriptors": [
                {
                  "handle": 30,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 31,
                  "permission": 0,
                  "uuid": "00002312-0000-1000-8000-00805f9b34fb"
                }
              ]
            }
          ]
        },
        {
          "handle": 5,
          "type": 0,
          "uuid": "00001400-0000-1000-8000-00805f9b34fb",
          "characteristics": [
            {
              "uuid": "00002401-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 20,
              "permission": 0,
              "handle": 14,
              "descriptors": [
                {
                  "handle": 32,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 33,
                  "permission": 0,
                  "uuid": "00002411-0000-1000-8000-00805f9b34fb"
                }
              ]
            },
            {
              "uuid": "00002402-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 30,
              "permission": 17,
              "handle": 15,
              "descriptors": [
                {
                  "handle": 34,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 35,
                  "permission": 0,
                  "uuid": "00002412-0000-1000-8000-00805f9b34fb"
                }
              ]
            }
          ]
        },
        {
          "handle": 6,
          "type": 0,
          "uuid": "00001500-0000-1000-8000-00805f9b34fb",
          "characteristics": [
            {
              "uuid": "00002501-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 20,
              "permission": 0,
              "handle": 16,
              "descriptors": [
                {
                  "handle": 36,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 37,
                  "permission": 0,
                  "uuid": "00002511-0000-1000-8000-00805f9b34fb"
                }
              ]
            },
            {
              "uuid": "00002502-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 30,
              "permission": 17,
              "handle": 17,
              "descriptors": [
                {
                  "handle": 38,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 39,
                  "permission": 0,
                  "uuid": "00002512-0000-1000-8000-00805f9b34fb"
                }
              ]
            }
          ]
        },
        {
          "handle": 7,
          "type": 0,
          "uuid": "00001600-0000-1000-8000-00805f9b34fb",
          "characteristics": [
            {
              "uuid": "00002601-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 20,
              "permission": 0,
              "handle": 18,
              "descriptors": [
                {
                  "handle": 40,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 41,
                  "permission": 0,
                  "uuid": "00002611-0000-1000-8000-00805f9b34fb"
                }
              ]
            },
            {
              "uuid": "00002602-0000-1000-8000-00805f9b34fb",
              "writeType": 1,
              "property": 30,
              "permission": 17,
              "handle": 19,
              "descriptors": [
                {
                  "handle": 42,
                  "permission": 0,
                  "uuid": "00002902-0000-1000-8000-00805f9b34fb"
                },
                {
                  "handle": 43,
                  "permission": 0,
                  "uuid": "00002612-0000-1000-8000-00805f9b34fb"
                }
              ]
            }
          ]
        }
      ]

    writeCharacteristic: ->
    enableNotification: ->


checkForEvothings = ->
  setTimeout ->
    if evothings?
      console.log 'Found evothings', evothings
      foo.ble = evothings.ble
    else
      checkForEvothings()
  , 10

checkForEvothings()

`export default foo`