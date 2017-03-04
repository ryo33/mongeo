import React from 'react'

const ScoreBoard = ({ users }) => {
  const usersList = Object.keys(users).map(id => users[id])
    .sort((a, b) => a.score - b.score) // Desc
  return (
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Score</th>
        </tr>
      </thead>
      <tbody>
        {
          usersList.map(user => {
            return (
              <tr key={user.id}>
                <td>{user.id}</td>
                <td>{user.score}</td>
              </tr>
            )
          })
        }
      </tbody>
    </table>
  )
}

export default ScoreBoard
