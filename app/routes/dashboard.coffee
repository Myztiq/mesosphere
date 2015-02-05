`import Ember from 'ember'`

DashboardRoute = Ember.Route.extend

  setupController: (controller) ->
    controller.set 'apps', @store.filter 'app', {}, -> true
    controller.set 'servers', @store.filter 'server', {}, -> true


`export default DashboardRoute`
