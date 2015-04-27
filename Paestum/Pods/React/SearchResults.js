'use strict'

var React = require('react-native');
var ContentView = require('./ContentView');
var {
	StyleSheet,
	Image,
	View,
	TouchableHighlight,
	ListView,
	Text,
	Component
} = React;

var styles = StyleSheet.create({
  thumb: {
    width: 80,
    height: 80,
    marginRight: 10
  },
  textContainer: {
    flex: 1
  },
  separator: {
    height: 1,
    backgroundColor: '#dddddd'
  },
  price: {
    fontSize: 25,
    fontWeight: 'bold',
    color: '#48BBEC'
  },
  title: {
    fontSize: 20,
    color: '#656565'
  },
  rowContainer: {
    flexDirection: 'row',
    padding: 10
  }
});

var imgurl = 'http://frimages.firstrain.com/imagerepository/0/1027/f9/f8/f9f8f600-3d44-11e3-bcb3-0019b9cc211b.gif';
//var imgurl='http://2.l.uk.nestoria.nestimg.com/lis/1/8/d/648bc5ac2407c4cdaf1c907210970ff7c95e6.2.jpg';

class SearchResults extends Component{
	constructor (props){
		super (props);
		var dataSource = new ListView.DataSource({rowHasChanged: (r1, r2)=> r1.guid !== r2.guid});
		this.state = {
			dataSource:dataSource.cloneWithRows(this.props.listings)
		};
	}

	renderRow(rowData, sectionID, rowID) {
		var price = rowData.price;//_formatted.split('')[0];
		return (
			<TouchableHighlight onPress={()=>this.rowPressed(rowData.guid)} underlayColor='#dddddd'>
				<View>
					<View style={styles.rowContainer}>
						<Image style={styles.thumb} source={{uri: rowData.img_url}}/>
						<Image style={styles.thumb} source={{uri: imgurl}}/>
						<View style={styles.textContainer}>
							<Text style={styles.price}>${price}</Text>
							<Text style={styles.title} numberOfLines={1}>{rowData.title}</Text>
						</View>
					</View>
					<View style={styles.separator}/>
				</View>
			</TouchableHighlight>
		);
	}

	rowPressed(propertyGuid){
		var property = this.props.listings.filter(prop=>prop.guid === propertyGuid)[0];

		this.props.navigator.push({
			title: "Property",
			component: ContentView,
			passProps: {property: property}
		});
	}

	render(){
		return(
			<ListView dataSource={this.state.dataSource} renderRow={this.renderRow.bind(this)}/>
		);
	}
}

module.exports = SearchResults;