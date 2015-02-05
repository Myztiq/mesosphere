`import DS from "ember-data"`
`import Ember from 'ember'`

AppModel = DS.Model.extend
  created: DS.attr('string')
  appStarted: DS.attr('string')
  app: DS.belongsTo('app')

  inUse: Ember.computed.notEmpty 'app'

  appWatcher: (->
    if @get('app')?
      @set 'appStarted', new Date()
    else
      @set 'appStarted', null
  ).observes 'app'

AppModel.reopenClass
  FIXTURES: [
    {
      id: 'server1'
      created: new Date()
      app: null
    }
    {
      id: 'server2'
      created: new Date()
      app: null
    }
  ]

`export default AppModel`
