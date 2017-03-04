import React from 'react'
import { render } from 'react-dom'
import { createStore, applyMiddleware } from 'redux'
import { Provider } from 'react-redux'

import { addVertex, updateState, updateUser } from './actions.js'
import reducer from './reducers.js'
import middleware from './middlewares.js'
import { channel } from './socket.js'
import App from './components/App.js'

const store = createStore(
  reducer,
  applyMiddleware(middleware)
)

channel.on('update', ({ match: state }) => {
  store.dispatch(updateState(state))
})

channel.join()
  .receive('ok', ({ user, match: state }) => {
    store.dispatch(updateUser(user))
    store.dispatch(updateState(state))
  })
  .receive('error', resp => console.error(resp))

render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('root')
)
