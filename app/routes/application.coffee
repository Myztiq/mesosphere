`import Ember from 'ember'`

ApplicationRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo 'dashboard'

`export default ApplicationRoute`
