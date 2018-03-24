import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function game_init(root, channel) {
  ReactDOM.render(<Answer channel = {channel} />, root);
}

class Answer extends React.Component{

  constructor(props) {
    super(props);

    this.channel = props.channel;

    this.state = {
      active_quests: ["1","2"],
      questions: [],
      p1_score: 0,
      p2_score: 0,
      p1_chance: 1,
      p2_chance: 1
    }
  }

  gotView(msg) {
    console.log("Got View", msg);
    this.setState(msg.view);
  }

  render(){
    let active_quests = this.state.active_quests;

    return(
      <div className='container'>
        <div className='row'>
          <Score state={this.state} />
        </div>

        <div className='row'>
          <div className='col-md-12'>
            <div className='grid-container'>
              {active_quests.map( (card,i) =>
                <div className="grid-item" key={i} ><Card root={this} index={card["index"]} /></div>
              )}
            </div>
          </div>
        </div>

      </div>
    );
  }
}

function Card(props) {
  let cards = props.root.state.active_quests;

  return(<div className="hide-card" onClick={() => console.log("TODO")}>??</div>);

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
