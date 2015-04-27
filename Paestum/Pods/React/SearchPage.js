'use strict';

var React = require('react-native');

var SearchResults = require('./SearchResults');

var {
	StyleSheet,
	Text,
	TextInput,
	View,
	TouchableHighlight,
	ActivityIndicatorIOS,
	Image,
	Component
} = React;

var styles = StyleSheet.create({
	thumb: {
	    width: 80,
	    height: 80,
	    marginRight: 10
  	},
  	imageContainer: {
	    flex: 1,
	    alignItems: 'stretch',
	    width:100,
	    height:100
  	},
  	imageflex: {
    	flex: 1
  	},
  	description:{
		marginBottom: 20,
		fontSize: 18,
		textAlign: 'center',
		color: '#656565'
	},
	container:{
		padding:30,
		marginTop: 65,
		alignItems: 'center'
	},
	flowRight:{
		flexDirection:'row',
		alignItems:'center',
		alignSelf:'stretch'
	},
	buttonText:{
		fontSize:18,
		color:'white',
		alignSelf:'center'
	},
	button: {
	  height: 36,
	  flex: 1,
	  flexDirection: 'row',
	  backgroundColor: '#48BBEC',
	  borderColor: '#48BBEC',
	  borderWidth: 1,
	  borderRadius: 8,
	  marginBottom: 10,
	  alignSelf: 'stretch',
	  justifyContent: 'center'
	},
	searchInput: {
	  height: 36,
	  padding: 4,
	  marginRight: 5,
	  flex: 4,
	  fontSize: 18,
	  borderWidth: 1,
	  borderColor: '#48BBEC',
	  borderRadius: 8,
	  color: '#48BBEC'
	},
	image:{
		width:100,
		height:100,
		resizeMode:'contain'
	}
});

//var imgurl = 'https://frimages.firstrain.com/imagerepository/0/1027/f9/f8/f9f8f600-3d44-11e3-bcb3-0019b9cc211b.gif';
var imgurl = 'https://frimages.firstrain.com/imagerepository/0/1096/fd/a6/fda679c0-735f-11e3-ae24-0019b9cc211b.gif';
function urlForQueryAndPage(key, value, pageNumber) {
  // var data = {
  //     country: 'uk',
  //     pretty: '1',
  //     encoding: 'json',
  //     listing_type: 'buy',
  //     action: 'search_listings',
  //     page: pageNumber
  // };


  // var data = {"count":8,"frEntityId":"-1","lastMinutes":43200,"componentId":1000,"frUserId":3177532,"channelId":1,"cardId":1};

  var data = {count:8,frEntityId:'-1',lastMinutes:43200,componentId:1000,frUserId:3177532,channelId:1,cardId:1};


  //data[key] = value;
 
  var querystring = Object.keys(data)
    .map(key => key + '=' + encodeURIComponent(data[key]))
    .join('&');
 
  //return 'http://api.nestoria.co.uk/api?' + querystring;
	//console.log('************' + querystring + '*****************');


  return 'https://devapps.firstrain.com/paestumstatic/static/paestum/getDataForCard.json';
};

class SearchPage extends Component{

	constructor(props){
		super(props);
		this.state={
			searchString:'london',
			isLoading:false,
			message:''
		};
	}


	render(){
		//console.log('SearchPage.render');
		var spinner = this.state.isLoading?(<ActivityIndicatorIOS hidden='true' size='large' />):(<View/>);
		return(
			<View style={styles.container}>
				<Text style={styles.description}>
					Search!
				</Text>
				<Text style={styles.description}>
					Search by...
				</Text>
				<View style={styles.flowRight}>
					<TextInput
						style={styles.searchInput}
						value={this.state.searchString}
						onChange={this.onSearchTextChanged.bind(this)}
						placeholder='Search here'/>
					<TouchableHighlight style={styles.button} underlayColor='#99d9f4'
						onPress={this.onSearchPressed.bind(this)}>
						<Text style={styles.buttonText}>Go!</Text>
					</TouchableHighlight>
				</View>	
				<TouchableHighlight style={styles.button} underlayColor = '#99d9f4'>
					<Text style={styles.buttonText}>Search!</Text>
				</TouchableHighlight>
				<Image source={require('image!searchimage')} style={styles.image}/>
        		<Image style={styles.image} source={{uri:imgurl}} />
				{spinner}
				<Text style={styles.description}>{this.state.message}</Text>
			</View>
		);
	}

	_executeQuery(query){
		//console.log(query);
		this.setState({isLoading:true})


        fetch(query, {
  			method: 'post',
  			headers: {
    			'Accept': 'application/json',
    			'Content-Type': 'application/json'
  			},
  			body: JSON.stringify({
  				count:8,frEntityId:'-1',lastMinutes:43200,componentId:1000,frUserId:3177532,channelId:1,cardId:1
  			})
  			
		})
			.then(data=>data.text())
			.then(text=>JSON.parse(text))
			.then(json => this._handleResponse(json))
			.catch(error => this.setState({
				isLoading:false, message:'Something bad happended ' + error 
			}));
	}

	_handleResponse(response){
		console.log(response);
		this.setState({isLoading:false, message:''});
		if(response.status==='SUCCESS'){
			this.props.navigator.push({
				title:'Results',
				component:SearchResults,
				passProps:{listings: response.data}
			});
		}else{
			this.setState({message: response.message});
		}
	}

	onSearchPressed(){
		var query = urlForQueryAndPage('place_name', this.state.searchString, 1);
		console.log(query);
		this._executeQuery(query);
	}

	onSearchTextChanged(event){
		//console.log('onSearchTextChanged');
		this.setState({searchString: event.nativeEvent.text});
		//console.log(this.state.searchString);
	}
}

module.exports = SearchPage;











