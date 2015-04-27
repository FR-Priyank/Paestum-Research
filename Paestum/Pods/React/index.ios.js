'use strict';

var React = require('react-native');

var {
  Text,
  View
} = React;

var CardView = require('./CardView');

var styles = React.StyleSheet.create({
  text:{
    color:'black',
    backgroundColor:'white',
    fontSize: 30,
    margin: 80
  },
  container:{
    flex:1,
    backgroundColor: 'lightblue'
  },
  image: {
    width: 44,
    height: 44,
    resizeMode: 'contain'
  }
});

class MySimpleApp extends React.Component {
  render() {
     return <CardView />;
  }
}

React.AppRegistry.registerComponent('SimpleApp', () => MySimpleApp);