'use strict';
 
var React = require('react-native');
var {
  StyleSheet,
  Image, 
  View,
  Text,
  ListView,
  ActivityIndicatorIOS,
  NavigatorIOS,
  TabBarIOS,
  Component
} = React;

var styles = StyleSheet.create({
  container: {
    marginTop: 5,
    marginBottom: 5,
    flex: 1
  },
  maincontainer:{
    padding:5,
    marginTop: 5,
    flex:1
  },

  textContainer: {
    flex: 1
  },
  separator: {
    height: 1,
    backgroundColor: '#DDDDDD'
  },
  image: {
    width: 80,
    height: 50,
    resizeMode: 'contain'
  },
  price: {
    fontSize: 25,
    fontWeight: 'bold',
    margin: 5,
    color: '#48BBEC'
  },
  title: {
    fontSize: 20,
    fontFamily: 'HelveticaNeue-Light',
    backgroundColor:'white',
    alignSelf: 'center',
    margin: 5,
    marginRight : 5,
    color: '#656565' 
  },
  description: {
    fontSize: 18,
    backgroundColor:'white',
    margin: 5,
    color: '#656565'
  },
  newdescription:{
    marginBottom: 5,
    backgroundColor:'white',
    fontSize: 18,
    textAlign: 'center',
    color: '#656565'
  },
  heading: {
    fontSize: 25,
    fontWeight: 'bold',
    backgroundColor:'white',
    fontFamily: 'HelveticaNeue-Light',
    alignSelf: 'center',
    margin: 5,
    color: '#656565'
  },
  rowContainer: {
    flexDirection: 'row',
    flex:1,
    marginLeft:5,
    padding: 5
  }
});

class CardView extends Component{

  constructor(props){
    super(props);
    this.state={
      isLoading:true,
      data:'',
      message:'',
      dataSource:new ListView.DataSource({rowHasChanged: (r1, r2)=> r1 !== r2})
    };
  }

  componentDidMount(){
    this.fetchData(); 
  }

  render(){ 
    if (this.state.message){
      return this.renderError();
    }

    if (!this.state.data) { 
      return this.renderLoadingView(); 
    } 

    return this.renderContent(); 
  }

  renderLoadingView() { 
    var spinner = this.state.isLoading?(<ActivityIndicatorIOS hidden='true' size='large' />):(<View/>);
    return ( 
      <View style={styles.maincontainer}> 
        {spinner} 
      </View> 
    ); 
  } 

renderError(){ 
    return ( 
      <View style={styles.maincontainer}>
        <Text style={styles.description}>
          {this.state.message}
        </Text>
      </View> 
    ); 
  }
  
  renderContent(){ 
    return ( 
      <View style={styles.maincontainer}> 
        <Text style={styles.heading}>Who To Call</Text>
        <ListView dataSource={this.state.dataSource} renderRow={this.renderRow}/>
      </View> 
    ); 
  }

  renderRow(rowData, sectionID, rowID) {
    return (
        <View>
          <View style={styles.rowContainer}>
              <Image style={styles.image} source={{uri: rowData.account.companyLogoUrl}}/>
              <Text style={styles.title} numberOfLines={1}>{rowData.account.name}</Text>
          </View>
          <View style={styles.separator}/>
        </View>
      
    );
  }

  fetchData(){
    
    this.setState({isLoading:true, message:''});

    var queryurl = 'https://devapps.firstrain.com/paestumstatic/static/paestum/getDataForCard.json';

    fetch(queryurl, {
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
      .then(json => this.handleResponse(json))
      .catch(error => this.setState({
        isLoading:false, message:'Something bad happended ' + error, data:'' 
      }));
   }

  handleResponse(response){
    if(response.status==='SUCCESS'){
      this.setState({data:response.data});
      this.setState({isLoading:false, message:''});
      this.setState({dataSource:this.state.dataSource.cloneWithRows(response.data.whoToCallPage.topAccount)})
    }else{
      this.setState({isLoading:false, message: response.message});
    }
  }
}

module.exports = CardView;