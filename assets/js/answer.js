import React from 'react';
import ReactDOM from 'react-dom';

export default function game_init(root, channel) {
  ReactDOM.render(<Answer channel = {channel} />, root);
}

class Answer extends React.Component{

  constructor(props) {
    super(props);

    this.channel = props.channel;

    this.state = {
      active_quests: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
      questions: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
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

  user_click(ev) {
    let index = $(ev.target).attr('index');
    if($(ev.target).hasClass('hide-card')){
      return;
    }
    $(ev.target).addClass('hide-card');
    let question = this.state.questions[index];
    document.createElement('p');
    document.createTextNode(question);
    

    //$('#question').
  }
/*
  user_click(index) {

      this.channel.push("user_click", { index: index} )
      .receive("ok", this.gotView.bind(this));
      let attempts = this.state.attempts;
      if (attempts % 2 == 1) {
        console.log(attempts);
        window.setTimeout( () => {
          this.channel.push("card_match", { index: index})
          .receive("ok", this.gotView.bind(this));
        }, 1500);
      }
  }
*/


  render(){
    let cards = this.state.active_quests;

    return(
      <div className='container'>
        <div className='row'>
          <Score state={this.state} />
        </div>

        <div className='row'>
          <div className='col-md-12'>
            <div className='grid-container'>
              {cards.map( (card,i) =>
                <div className="grid-item" key={i} ><Card root={this} index={i} /></div>
              )}
            </div>
          </div>
        </div>

        <div className='row' id='question'>

        </div>

      </div>
    );
  }
}



function Card(props) {
  let cards = props.root.state.active_quests;
  let index = props.index;
  // onClick={ () => props.root.user_click(props.index)}
  return(<div className="show-card" onClick={(ev) => props.root.user_click(ev)}>{index}</div>);

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
