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
      answer: ''     

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
    if(this.state.answer[0] === answer){
      
       this.channel.push("score-check", {question: question}).receive("ok", this.gotView.bind(this))
       alert("correct answer");
}    else
    {
    alert(`Wrong ! You should chose ${this.state.answer} .`);
  }
}

 user_click(index1)
{
    let active_scores = this.state.active_scores;
    if(active_scores[index1] != "*"){
       console.log(this.state.questions[index1])
       document.getElementById('question').innerHTML = this.state.questions[index1];
      
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
          <Score state = {this.state} />
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
 <form onSubmit={this.handleSubmit}>        
        <ul>
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

  return (
    <div className='col-md-6'>
      <p><b>Player_1 Score: { p1_score }</b></p>
      <p><b>Player_2 Score: { p2_score } </b></p>
    </div>
  );
}

function Topics(props) {
return (
   <div className = 'topic-card' >
                <Button className ={props.className} >
                {props.value}
</Button></div>);
}
/*
function Alternatives(props){
// console.log(props.value.length);
  if(props.value.length == 0){
   console.log(props.value);
   return(<div> </div>);
}
else{
return (<div>
        <h1> hey</h1>
    <form onSubmit={this.handleSubmit}>
        <p className="title">Select a pizza size:</p>
        
        <ul>
          <li>
            <label>
              <input
                type="radio"
                value= {Enum.at(props.value, 0)}
                checked={this.state.user_answer == Enum.at(props.value, 0)}
                onChange={this.handleChange}
              />
              {Enum.at(props.value, 0)}
            </label>
          </li>
          
          <li>
            <label>
              <input
                type="radio"
                value= "medium"
                checked={this.state.user_answer == "medium"}
                onChange={this.handleChange}
              />
              "medium"
            </label>
          </li>

          <li>
            <label>
              <input
                type="radio"
                value= "large"
                checked={this.state.user_answer == "large"}
                onChange={this.handleChange}
              />
              "large"
            </label>
          </li>
        </ul>

        <button type="submit" className="submit-button">Make your choice</button>
      </form>
</div>);
}
}
*/
