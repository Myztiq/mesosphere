`import Ember from 'ember'`

DashboardController = Ember.Controller.extend
  servers: []

  createdSortedServers: Ember.computed.sort 'servers', (server1, server2)->
    server1.get('created') - server2.get('created')

  availableServers: (->
    @get('createdSortedServers').filter (server)->
      !server.get('isFull')
  ).property 'createdSortedServers.@each.isFull'

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
        @send 'addInstance', instance.get('app')

    addInstance: (app) ->
      server = @get('prioritizedServers.firstObject')
      if server?
        instance = @store.createRecord 'appInstance',
          app: app
          server: server

        Ember.run.later ->
          unless instance.get('isDestroyed')
            instance.set('active', true)
        , 3000 * Math.random()
      else
        console.log 'No available servers to add this app to'

    removeLastInstance: (app) ->
      instance = app.get('instances').sortBy('started').get('lastObject')
      if instance?
        instance.destroyRecord()
      else
        console.log 'No app instances remaining'

    removeInstance: (instance)->
      instance.destroyRecord()

`export default DashboardController`
