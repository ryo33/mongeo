import { createAsyncHook } from 'redux-middlewares'

import { channel } from './socket.js'
import { addVertex } from './actions.js'

const addVertexMiddleware = createAsyncHook(
  addVertex.getType(),
  ({ action }) => {
    channel.push("add_vertex", action.payload)
      .receive('ok', () => {})
  }
)

export default addVertexMiddleware
