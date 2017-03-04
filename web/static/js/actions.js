import { createAction } from 'redux-act'

export const addVertex = createAction('add vertex', (x, y) => ({x, y}))
export const updateState = createAction('update state', state => state)
export const updateUser = createAction('update user', user => user)
