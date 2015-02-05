`import Ember from 'ember'`

DashboardController = Ember.Controller.extend
  servers: []

  emptyServers: Ember.computed.filterBy 'servers', 'inUse', false

  actions:
    addServer: ->
      @store.createRecord 'server',
        created: new Date()

    removeLastServer: ->
      @get('servers.lastObject').destroy()

    addApp: (app) ->
      servers = @get('emptyServers')
      server = servers.get('firstObject')
      server?.set 'app', app

    removeLastApp: (app) ->
      app.get('servers').sortBy('appStarted').get('lastObject')?.set('app', null)

`export default DashboardController`
