`import DS from "ember-data"`;

AppModel = DS.Model.extend
  name: DS.attr('string')
  color: DS.attr('string')
  servers: DS.hasMany('server')

  abbreviation: (->
    name = @get('name')
    return name[0].toUpperCase() + name[1]
  ).property 'name'


AppModel.reopenClass
  FIXTURES: [
    {
      id: 'hadoop'
      name: 'Hadoop'
      color: '#C10DC8'
    }
    {
      id: 'rails'
      name: 'Rails'
      color: '#2B2FF2'
    }
    {
      id: 'chronos'
      name: 'Chronos'
      color: '#08BAFB'
    }
    {
      id: 'storm'
      name: 'Storm'
      color: '#30E290'
    }
    {
      id: 'spark'
      name: 'Spark'
      color: '#6AF410'
    }
  ]

`export default AppModel`
