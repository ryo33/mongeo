import React, { Component } from 'react'
import { connect } from 'react-redux'

import { addVertex } from '../actions.js'
import GeolocationButton from './GeolocationButton.js'
import Map from './Map.js'
import ScoreBoardButton from './ScoreBoardButton.js'

const mapStateToProps = state => {
  const { match, user } = state
  return {match, user}
}

const actionCreators = {
  addVertex
}

class App extends Component {
  constructor(props) {
    super(props)
    this.handleClick = this.handleClick.bind(this)
    this.state = {
      currentX: 0,
      currentY: 0
    }
  }

  componentDidMount() {
    navigator.geolocation.watchPosition((pos) => {
      const coords = pos.coords
      const x = coords.longitude
      const y = coords.latitude
      this.setState({
        currentX: x,
        currentY: y
      })
    })
  }

  handleClick() {
    const { addVertex } = this.props
    const { currentX, currentY } = this.state
    addVertex(currentX, currentY)
  }

  render() {
    const { match: {users, areas}, user } = this.props
    const { currentX, currentY } = this.state
    if (users) {
      return (
        <div>
          <div style={{position: 'fixed', top: '0px', left: '0px'}}>
            <Map users={users} areas={areas} user={user}
              currentX={currentX} currentY={currentY} />
          </div>
          <div style={{position: 'absolute', top: '0px', left: '0px'}}>
            <GeolocationButton
              currentX={currentX} currentY={currentY}
              onClick={this.handleClick}
            />
            <ScoreBoardButton users={users} />
          </div>
        </div>
      )
    } else {
      return null
    }
  }
}

export default connect(mapStateToProps, actionCreators)(App)
