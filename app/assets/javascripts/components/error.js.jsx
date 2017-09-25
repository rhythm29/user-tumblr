//Error Component used by all other components for showing errors.
function Error(props){
	return(
		<div>
			<h3 className="errorMsg"> {props.msg} </h3>
		</div>
	)	
}