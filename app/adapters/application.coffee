`import DS from "ember-data"`;

ApplicationAdatper = DS.FixtureAdapter.extend
  queryFixtures: (objects)->
    return objects

`export default ApplicationAdatper`;
