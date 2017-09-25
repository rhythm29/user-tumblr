//Login component for creating login page.
class Login extends React.Component{
  constructor(props){
    super(props);
    this.state = {email:'', password: '', errors:''}
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e){
    if(e.target.id == "email"){
      this.setState({email: e.target.value})
    }
    else{
      this.setState({password: e.target.value})
    }
  }

  handleSubmit (e) {
    e.preventDefault();
    var  currentComponent = this;
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/sessions/login', true);
    xhr.setRequestHeader('Content-type', 'application/json');
    xhr.onload = function () {
      if(this.status == 200){
        window.location.replace("/posts/")
      }
      else if(this.status == 401){
        currentComponent.setState({errors: "Login Failed. Check Username and Password"})
      }
    };
    console.log(this.state)
    xhr.send(JSON.stringify(this.state));
    
  }
  render(){
    return(
      <div className="login">
        <form onSubmit={this.handleSubmit}>
          <input type="text"  className="login_input" id="email" placeholder="Email/Username" value={this.state.email} onChange={this.handleChange} />
          <input type="password" className="login_input" id="password" placeholder="password" value={this.state.password} onChange={this.handleChange} />
          <input type="submit" className="login_input" value="Send" />
        </form>
        {this.state.errors? <Error msg= {this.state.errors} />: null}
      </div>
    )
  }
}