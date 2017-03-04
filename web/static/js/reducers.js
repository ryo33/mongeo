import { combineReducers } from 'redux'
import { createReducer } from 'redux-act'

import { updateState, updateUser } from './actions.js'

const match = createReducer({
  [updateState]: (state, payload) => payload
}, {})

const user = createReducer({
  [updateUser]: (state, payload) => payload
}, null)

export default combineReducers({match, user})
