const baseUrl = 'http://localhost:3000'

export const loginUser = (loginData) => {
  const opts = {
    method: 'POST',
    body: JSON.stringify(loginData),
    headers: {
      'Content-Type': 'application/json'
    }
  };

  return fetch(`${baseUrl}/auth/login`, opts)
    .then(resp => resp.json())
}

export const registerUser = (registerData) => {
  const opts = {
    method: 'POST',
    body: JSON.stringify({ user: registerData}),
    headers: {
      'Content-Type': 'application/json'
    }
  };

  return fetch(`${baseUrl}/users/`, opts)
    .then(resp => resp.json())
}

const createInstructor = (data) => {
  const opts = {
    method: 'POST',
    body: JSON.stringify(data),
    headers: {
      'Content-Type': 'application/json'
    }
  }
  return fetch(`${baseUrl}/instructors`, opts)
    .then(resp => resp.json())
}

const readAllInstructors = () => {
  return fetch(`${baseUrl}/instructors`)
    .then(resp => resp.json())
    .then(json => json.instructors)
}

const readOneInstructor = (id) => {
  return fetch(`${baseUrl}/instructors/${id}`)
    .then(resp => resp.json())
}

const updateInstructor = (id, data) => {
  const opts = {
    method: 'PUT',
    body: JSON.stringify(data),
    headers: {
      'Content-Type': 'application/json'
    }
  }
  return fetch(`${baseUrl}/instructors/${id}`, opts)
    .then(resp => resp.json())
}

const destroyInstructor = (id) => {
  const opts = {
    method: 'DELETE'
  }
  return fetch(`${baseUrl}/instructors/${id}`, opts)
}

export {
  createInstructor,
  readAllInstructors,
  readOneInstructor,
  updateInstructor,
  destroyInstructor
}