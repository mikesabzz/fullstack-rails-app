import React, { Component } from 'react';
import InstructorEdit from './InstructorEdit'
import { Route } from 'react-router-dom';
import { withRouter } from 'react-router';

class Instructor extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isEdit: false
    }
  }

  componentDidMount() {
    this.props.mountEditForm(this.props.id);
  }

  render() {
    const { instructor } = this.props;
    return (
      <div className="instructor-page">
        {instructor === undefined ? <h2>Loading . . .</h2> : (
          <div>
            <img alt={instructor.name} src={instructor.photo}/>
            <h1>{instructor.name}</h1>
            <p>{instructor.description}</p>
            <a href={instructor.link}>Connect</a>
            <hr/>
            {this.state.isEdit ?
              <Route path={'/instructors/:id/edit'} render={() => (
                <InstructorEdit
                  handleFormChange={this.props.handleFormChange}
                  handleSubmit={(e) => {
                    e.preventDefault();
                    this.props.editInstructor();
                    this.setState({ isEdit: false })
                    this.props.history.push(`/instructors/${this.props.instructorForm.id}`)
                  }}
                  instructorForm={this.props.instructorForm} />
              )} />
              :
              <>
                <button onClick={() => {
                  this.setState({
                    isEdit: true
                  })
                  this.props.history.push(`/instructors/${instructor.id}/edit`)
                }}>Edit</button>
                <button onClick={() => {
                  this.props.deleteInstructor(instructor.id);
                  this.props.history.push('/')
                }}>Delete</button>
              </>
            }
          </div>)}
      </div>)
  }
}

export default withRouter(Instructor);