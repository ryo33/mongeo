import React, { Component } from 'react'

import ScoreBoard from './ScoreBoard.js'

class ScoreBoardButton extends Component {
  constructor(props) {
    super(props)
    this.handleClick = this.handleClick.bind(this)
    this.state = {
      open: false
    }
  }

  handleClick() {
    this.setState({
      open: !this.state.open
    })
  }

  render() {
    return (
      <div>
        <button onClick={this.handleClick}>
          {this.state.open ? 'スコアボードを閉じる' : 'スコアボード'}
        </button>
        {this.state.open ? (
          <ScoreBoard {...this.props} />
        ) : null}
      </div>
    )
  }
}

export default ScoreBoardButton
