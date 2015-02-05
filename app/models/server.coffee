`import DS from "ember-data"`
`import Ember from 'ember'`

AppModel = DS.Model.extend
  created: DS.attr('string')
  appInstances: DS.hasMany('appInstance')

  inUse: Ember.computed.notEmpty 'appInstances'

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
    }
    {
      id: 'server2'
      created: new Date()
    }
    {
      id: 'server3'
      created: new Date()
    }
    {
      id: 'server4'
      created: new Date()
    }
  ]

`export default AppModel`
