`import DS from "ember-data"`;

AppModel = DS.Model.extend
  name: DS.attr('string')
  instances: DS.hasMany('appInstance')

  abbreviation: (->
    name = @get('name')
    return name[0].toUpperCase() + name[1]
  ).property 'name'


AppModel.reopenClass
  FIXTURES: [
    {
      id: 'hadoop'
      name: 'Hadoop'
    }
    {
      id: 'rails'
      name: 'Rails'
    }
    {
      id: 'chronos'
      name: 'Chronos'
    }
    {
      id: 'storm'
      name: 'Storm'
    }
    {
      id: 'spark'
      name: 'Spark'
    }
  ]

`export default AppModel`
