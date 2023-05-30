import React from 'react';
import { withRouter } from 'react-router';

function Instructors(props) {
  return (
    <div className="instructor-container">
      {props.instructors.map(instructor => (
        <div
          key={instructor.id}
          className="instructor-card"
          onClick={() => {
            props.history.push(`/instructors/${instructor.id}`)
            window.scrollTo(0, 0);
          }}>
          <img alt={instructor.name} src={instructor.photo} />
          <h3>
            <p>{instructor.name}</p>
          </h3>
        </div>
      ))}
      <div
        className="instructor-card"
        onClick={() => props.history.push('/new/instructor')}>
        <img
          alt="Create a new instructor"
          src="https://image.flaticon.com/icons/png/512/14/14980.png"
          className="plus-sign" />
        <h3>Create a new instructor</h3>
      </div>
    </div>
  )
}

export default withRouter(Instructors)