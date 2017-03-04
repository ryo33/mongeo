import React, { Component } from 'react'

class GeolocationButton extends Component {
  constructor(props) {
    super(props)
    this.handleClick = this.handleClick.bind(this)
  }

  handleClick() {
    const { currentX, currentY, onClick } = this.props
    this.lastX = currentX
    this.lastY = currentY
    onClick()
  }

  render() {
    const { currentX, currentY } = this.props
    const disabled = this.lastX == currentX && this.lastY == currentY
    return (
      <button onClick={this.handleClick} disabled={disabled}>
        位置情報を送信
      </button>
    )
  }
}

export default GeolocationButton
