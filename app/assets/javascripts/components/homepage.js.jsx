//Main component. It calls login or signup component based on the state.
class HomePage extends React.Component{
  constructor(props){
    super(props);
    this.state = {signup: false, login: true}
    this.switch = this.switch.bind(this);
  }
  switch(word){
    var signup,login;
    if(word == "signup"){signup = true;login = false;}
    else{login = true; signup = false;}
    return this.setState({login:login,signup:signup}) 
 }
  render(){
    return(
      <div className="space">
        <p onClick={() => this.switch("signup")} className={this.state.signup ? "yellow selectButton":"selectButton"}>Sign In</p>
        <p onClick={() => this.switch("login")} className={this.state.login ? "yellow selectButton":"selectButton"}> Login</p>
        {this.state.signup?<Signup/> : null}
        {this.state.login? <Login /> : null}
      </div>
    )
  }
}