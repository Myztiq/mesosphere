`import DS from "ember-data"`
`import Ember from 'ember'`

AppInstance = DS.Model.extend
  appStarted: DS.attr('string')

  app: DS.belongsTo('app')
  server: DS.belongsTo('server')
  active: DS.attr('boolean')

  appWatcher: (->
    if @get('app')?
      @set 'appStarted', new Date()
    else
      @set 'appStarted', null
  ).observes 'app'

`export default AppInstance`
