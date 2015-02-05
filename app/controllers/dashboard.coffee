`import Ember from 'ember'`

DashboardController = Ember.Controller.extend
  servers: []

  createdSortedServers: Ember.computed.sort 'servers', (server1, server2)->
    server1.get('created') - server2.get('created')

  availableServers: (->
    @get('createdSortedServers').filter (server)->
      server.get('appInstances.length') < 2
  ).property 'createdSortedServers.@each.appInstances.length'

  prioritizedServers: Ember.computed.sort 'availableServers', (server1, server2)->
    server1.get('appInstances.length') - server2.get('appInstances.length')

  actions:
    addServer: ->
      @store.createRecord 'server',
        created: new Date()
        apps: Ember.A()

    removeLastServer: ->
      instances = @get('createdSortedServers.lastObject.appInstances')
      @get('createdSortedServers.lastObject').destroyRecord()
      instances.forEach (instance)=>
        @send 'addApp', instance.get('app')

    addApp: (app) ->
      server = @get('prioritizedServers.firstObject')
      console.log server
      if server?
        @store.createRecord 'appInstance',
          app: app
          server: server
      else
        console.log 'No available servers to add this app to'

    removeLastApp: (app) ->
      instance = app.get('instances').sortBy('started').get('lastObject')
      if instance?

        instance.destroyRecord()
      else
        console.log 'No app instances remaining'

`export default DashboardController`
