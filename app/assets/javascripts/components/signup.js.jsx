//React Component for Signup form.
class Signup extends React.Component{
  constructor(props){
    super(props);
    this.state = {username:'', email:'', password: '' ,password_confirmation:'', errors:''}
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e){
    if(e.target.id == "username"){
      this.setState({username: e.target.value})
    }
    else if(e.target.id == "email"){
      this.setState({email: e.target.value})
    }
    else if(e.target.id =="password"){
      this.setState({password: e.target.value})
    }
    else{
      this.setState({password_confirmation: e.target.value})
    }
  }
  
  handleSubmit (e) {
    //Making AJAX call to send form data stored in state to backend
    var  currentComponent = this;
    e.preventDefault();
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/user/create', true);
    xhr.setRequestHeader('Content-type', 'application/json');
    xhr.onload = function() {
      if(this.status == 200){
        window.location.replace("/posts/")
      }
      else if(this.status == 422){
        currentComponent.setState({errors: JSON.parse(this.responseText)})
      }
    };
    xhr.send(JSON.stringify(this.state));
    
  }
  render(){
    return(
      <div className = "signup">
        <form onSubmit={this.handleSubmit}>
          <input type="text" className="input" id="username" placeholder="Username" value={this.state.username} onChange={this.handleChange} />
          <input type="text" className="email" id="email" placeholder="Email" value={this.state.email} onChange={this.handleChange} />
          <input type="password" className="password" placeholder="Password" id="password" value={this.state.password} onChange={this.handleChange} />
          <input type="password" className="input" placeholder="Confirm Password" id="password_confirmation" value={this.state.password_confirmation} onChange={this.handleChange} />
          <input type="submit" className="input" value="Send" />
        </form>
        {this.state.errors && this.state.errors["errors"]["username"]?this.state.errors["errors"]["username"][0]["error"]=="taken"?<Error msg="Username already taken" />: <Error msg="Username should be alphanumeric between 3 and 7 characters" />: null}
        {this.state.errors && this.state.errors["errors"]["email"]?this.state.errors["errors"]["email"][0]["error"]=="taken"?<Error msg="Email Id already taken" />: <Error msg="it should be a valid email id" />: null}
        {this.state.errors && this.state.errors["errors"]["password"]? <Error msg="Password should be more then 6 characters" />: null}
        {this.state.errors && this.state.errors["errors"]["password_confirmation"]? <Error msg="Passwords didn't match" />: null}      
      </div>
    )
  }
}