`import Ember from 'ember'`

DashboardController = Ember.Controller.extend
  servers: []

  availableServers: (->
    @get('servers').filter (server)->
      server.get('apps.length') < 2
  ).property 'servers.@each.apps.length'

  prioritizedServers: Ember.computed.sort 'availableServers', (server1, server2)->
    server1.get('apps.length') - server2.get('apps.length')

  actions:
    addServer: ->
      @store.createRecord 'server',
        created: new Date()

    removeLastServer: ->
      apps = @get('servers.lastObject.apps')
      @get('servers.lastObject').destroyRecord()
      apps.forEach (app)=>
        @send 'addApp', app

    addApp: (app) ->
      server = @get('prioritizedServers.firstObject')
      if server?
        server.get('apps').pushObject app
      else
        console.log 'No available servers to add this app to'

    removeLastApp: (app) ->
      apps = app.get('servers').sortBy('appStarted').get('lastObject.apps')
      if apps?
        apps.removeAt apps.indexOf(app)
      else
        console.log 'No app instances remaining'

`export default DashboardController`
