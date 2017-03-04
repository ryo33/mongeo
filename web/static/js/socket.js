import { Socket } from 'phoenix'

const token = window.token
const room = window.room

const socket = new Socket('/socket', {params: {token}})
socket.connect()
export const channel = socket.channel(`room:${room}`, {})
