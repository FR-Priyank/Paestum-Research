'use strict';

var React = require('react-native');

var {
  Text,
  View
} = React;

var CardView = require('./CardView');

var styles = React.StyleSheet.create({
  container:{
    flex:1,
    justifyContent:'center',
    backgroundColor: 'blue'
  }
});

class MySimpleApp extends React.Component {
  render() {
     return <CardView/>;
  }
}

React.AppRegistry.registerComponent('SimpleApp', () => MySimpleApp);