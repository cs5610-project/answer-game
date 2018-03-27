import React from 'react';
import ReactDOM from 'react-dom';
import { Button} from 'reactstrap';

export default function game_init(root, channel) {
  ReactDOM.render(<Answer channel = {channel} />, root);
}

const initState = {
      active_scores: [],
      questions: [],
      p1_score: 0,
      p2_score: 0,
      p1_chance: 1,
      p2_chance: 1,
      question_alts: [],
      user_answer: '',
      answer: '',
      player_capcity: 0,
      players: []     

    }


class Answer extends React.Component{

  constructor(props) {
    super(props);

    this.channel = props.channel;

    this.state = initState;
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.channel.join()
    .receive("ok", this.gotView.bind(this))
    .receive("error", resp => { console.log("Unable to join", resp) })
  }

  gotView(msg) {
    this.setState(msg.view);
  }
 

 handleChange(event) {
    this.setState({user_answer: event.target.value});
  }

  handleSubmit(event) {
    event.preventDefault();
    var question = document.getElementById('question').innerHTML;
   var  answer = this.state.user_answer;
    console.log(question, answer);
    console.log(this.state.answer);
    let a = document.getElementById("form");
    let b = document.getElementById("timer_div");
            	
    if(this.state.answer[0] === answer){
      
       this.channel.push("score-check", {question: question, answer: answer}).receive("ok", this.gotView.bind(this))
       alert("correct answer");
       document.getElementById('question').innerHTML = '';
       a.className = "hide";
       b.className = "hide";
       
}    else
    {
    alert(`Wrong ! You should chose ${this.state.answer} .`);
    document.getElementById('question').innerHTML = '';
    a.className = "hide";
    b.className = "hide";
  }
}

 reset(){
	this.channel.push("reset", {}).receive("ok", this.gotView.bind(this))
}

 user_click(index1)
{
    let active_scores = this.state.active_scores;
    if(active_scores[index1] != "*"){
       console.log(this.state.questions[index1])
       document.getElementById('question').innerHTML = this.state.questions[index1];
       let a = document.getElementById("form");
       a.className = "show";
       var seconds_left = 10;
var interval = setInterval(function() {
    document.getElementById('timer_div').innerHTML = --seconds_left;

    if (seconds_left <= 0)
    {   let  b = document.getElementById('timer_div');
         alert("Times up");
         
         document.getElementById('question').innerHTML = '';
         a.className = "hide";
         b.className = "hide";
 //      clearInterval(this.interval);

       clearInterval(interval);
    }
}, 1000);
       this.channel.push("user-click", {index: index1}).receive("ok", this.gotView.bind(this))
       
}
   else{
    alert("Question Attempted");
}
} 


  

  render(){
    let cards = this.state.active_scores;
    let topics = ["Space", "Technology", "Animals", "Food", "Art"];
    return(
      <div className='container'>
        <div className='row'>
          <Score state = {this.state} onClick = {this.reset.bind(this)}/>
         </div>

         <div className = 'row'>
                   <div className='col-md-8'>
            <div className='grid-topics'>

            {topics.map( (topic,i) =>
                 <Topics value={topic}  key = {i} />
              )}
         </div>
         </div>
        </div>
        <div className='row'>
          <div className='col-md-8'>
            <div className='grid-container'>

              {cards.map( (card,i) =>
               
                 <Card  onClick =  {this.user_click.bind(this,i)} value={card}  key = {i}/>
              )}
            </div>
          </div>
        </div>

        <div className='row' id='question'>
        </div>
<div id = "timer_div"> </div>
<div id="form" className = "hide">

 <form onSubmit={this.handleSubmit} >        
        <ul class = "alts-form">
          <li>
            <label class = "radio-inline">
              <input
                type="radio"
                value= {this.state.question_alts[0]}
                checked={this.state.user_answer ===  this.state.question_alts[0]}
                onChange={this.handleChange}
              />
              {this.state.question_alts[0]}
            </label>
          </li>
          
          <li>
            <label class = "radio-inline">
              <input
                type="radio"
                value= {this.state.question_alts[1]}
                checked={this.state.user_answer === this.state.question_alts[1]}
                onChange={this.handleChange}
              />

             {this.state.question_alts[1]}
            </label>
          </li>
          <li>
            <label class = "radio-inline">
              <input
                type="radio"
                value= {this.state.question_alts[2]}
                checked={this.state.user_answer === this.state.question_alts[2]}
                onChange={this.handleChange}
              />
              {this.state.question_alts[2]}
            </label>
          </li>
        
            <li>
            <label class = "radio-inline">
              <input
                type="radio"
                value= {this.state.question_alts[3]}
                checked={this.state.user_answer === this.state.question_alts[3]}
                onChange={this.handleChange}
              />
              {this.state.question_alts[3]}
            </label>
          </li>

        </ul>

        <button type="submit" className="submit-button">Make your choice</button>
      </form>
</div>
      </div>
    );
 
}
}



function Card(props) {
  return ( <div className ='show-card'>
        	<Button className ={props.className}  onClick ={props.onClick}>
        	{props.value}
</Button></div>);
}


function Score(props) {
  let p1_score = props.state.p1_score;
  let p2_score = props.state.p2_score;

  return (<div>
    <div className='col-md-6'>
      <p><b>Player_1 Score: { p1_score }</b></p>
      <p><b>Player_2 Score: { p2_score } </b></p>
    </div>

<div id = "reset"><Button className ="btn btn-success" onClick = {props.onClick}> Reset Game </Button></div></div>
  );
}

function Topics(props) {
return (
   <div className = 'topic-card' >
                <Button className ={props.className} >
                {props.value}
</Button></div>);
}
