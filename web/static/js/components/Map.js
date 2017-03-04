import React, { Component } from 'react'

const MARGIN = 10
const R = 6

class Map extends Component {
  constructor(props) {
    super(props)
    this.state = {
      width: window.innerWidth,
      height: window.innerHeight
    }
  }

  componentDidMount() {
    this.update()
  }

  componentDidUpdate() {
    this.update()
  }

  update() {
    const c = this.refs.canvas.getContext('2d')
    const { users, areas, currentX, currentY, user: me } = this.props
    const { width, height } = this.state

    c.save()
    c.clearRect(0, 0, width, height)
    let minX = currentX, minY = currentY,
      maxX = currentX, maxY = currentY
    const searchMinAndMax = (vertexes) => {
      vertexes.forEach(([x, y]) => {
        if (x < minX) minX = x
        if (x > maxX) maxX = x
        if (y < minY) minY = y
        if (y > maxY) maxY = y
      })
    }
    Object.keys(users).forEach(name => {
      const user = users[name]
      searchMinAndMax(user.vertexes)
    })
    Object.keys(areas).forEach(id => {
      const area = areas[id]
      searchMinAndMax(area.vertexes)
    })
    // fit to screen
    let ratio = 1
    let offsetX = MARGIN
    let offsetY = MARGIN
    if (minX === null) {
      minX = 0
      maxX = width
      minY = 0
      maxY = height
    }
    if (minX != maxX && minY != maxY) {
      const realWidth = maxX - minX
      const realHeight = maxY - minY
      const ratioX = (width - MARGIN * 2) / realWidth
      const ratioY = (height - MARGIN * 2) / realHeight
      if (ratioX < ratioY) {
        ratio = ratioX
        offsetY += (height - realHeight * ratioX) / 2
      } else {
        ratio = ratioY
        offsetX += (width - realWidth * ratioY) / 2
      }
    }
    const mapperX = (x) => (x - minX) * ratio + offsetX
    const mapperY = (y) => (y - minY) * ratio + offsetY
    const mapper = ([x, y]) => {
      return [mapperX(x), mapperY(y)]
    }
    Object.keys(users).forEach(name => {
      const user = users[name]
      if (user.vertexes.length >= 2) {
        this.renderLine(c, user.vertexes.map(mapper))
      }
      if (me == name && user.vertexes.length >= 1) {
        const point = user.vertexes[0]
        this.renderCircle(c, mapperX(point[0]), mapperY(point[1]), '#7e7')
      }
    })
    Object.keys(areas).forEach(id => {
      const area = areas[id]
      this.renderPolygon(c, area.vertexes.map(mapper))
    })
    this.renderCircle(c, mapperX(currentX), mapperY(currentY), '#e77')
    c.restore()
  }

  renderCircle(c, x, y, color) {
    c.strokeStyle = '#000'
    c.beginPath()
    c.fillStyle = color
    c.arc(x, y, R, 0, Math.PI*2, true)
    c.fill()
    c.stroke()
  }

  renderLine(c, points) {
    c.strokeStyle = '#000'
    c.beginPath()
    c.moveTo(points[0][0], points[0][1])
    for (let i = 1; i < points.length; i ++) {
      c.lineTo(points[i][0], points[i][1])
    }
    c.stroke()
  }

  renderPolygon(c, points) {
    c.strokeStyle = '#000'
    c.fillStyle = '#77e'
    c.beginPath()
    c.moveTo(points[0][0], points[0][1])
    for (let i = 1; i < points.length; i ++) {
      c.lineTo(points[i][0], points[i][1])
    }
    c.closePath()
    c.fill()
  }

  render() {
    const { width, height } = this.state
    return (
      <canvas
        ref="canvas"
        width={width}
        height={height}
      />
    )
  }
}

export default Map
