# ![](https://ga-dash.s3.amazonaws.com/production/assets/logo-9f88ae6c9c3871690e33280fcf557f33.png)  SOFTWARE ENGINEERING IMMERSIVE

## Getting started

1. Fork
1. Create a feature branch
1. Clone

# Rails as an API!

### Learning Objectives

- Create a REST-ful API in Rails
- Give our API Read All and Read One functionality with ActiveRecord
- Connect our Rails backend with a React frontend
- Display all of the data in our API's database

# Part One: Making a Rails API 

Today we create our new rails app, we'll be using: `--api`.

This does a couple of things:

- Configure your application to start with a more limited set of middleware than normal. Specifically, it will not include any middleware primarily useful for browser applications (like cookies support) by default.
- Make ApplicationController inherit from [ActionController::API](http://api.rubyonrails.org/classes/ActionController/API.html) instead of [ActionController::Base](http://api.rubyonrails.org/classes/ActionController/Base.html). As with middleware, this will leave out any Action Controller modules that provide functionalities primarily used by browser applications.
- Configure the generators to skip generating views, helpers and assets when you generate a new resource.

[(From the docs)](http://edgeguides.rubyonrails.org/api_app.html)

The end goal is a fully functioning Rails app with a React front end. With that in mind, let's get started.

### Generating the Rails app, creating the database, seeding the files

First we need to generate the app and create the database.

```bash
$ rails new . --api -G --database=postgresql
$ rails db:create
```

And, as always, it's a good idea to make sure that everything works before we go any farther.

Then, we need to generate the model. For this example, I'm doing a super simple database with just one table. (For your projects, you should have at least two!)

```bash
$ rails g model instructor name:string description:string link:string photo:string
$ rails db:migrate
```

**Remember**: in Rails, models are singlular. Controllers and routes are plural.

Let's make sure our database works by opening up the rails console and adding a teacher.

Lastly, we need to seed the database.

You can either move the provided `seed.rb` into your `/db/` directory or copy and paste this code into your existing seed file:

<details>
<summary>seed.rb</summary>

```
Instructor.create!(name: 'Bruno Galvao', description: 'Bruno has a background in software engineering and product management. He’s worked extensively with JavaScript, Ruby, and Python applications in micro-service environments. Bruno strongly believes in adopting agile methodologies, software craftsmanship, test-driven development (TDD), code reviews, and pair-programming as a foundation for scalable defect-free code. In the past, he has worked for small startups building products and in large companies working on cross-functional, self-organizing, autonomous teams writing high-quality maintainable code. When he is not hacking away on his Macbook he enjoys going for long runs and practicing yoga. As a SEI Instructor Lead, he brings his experience and passion to the classroom preparing students for a life-long journey in software development!', link: 'https://linkedin.com/in/brunopgalvao', photo: 'https://ga-core.s3.amazonaws.com/production/uploads/instructor/image/18686/thumb_bruno001.png')
Instructor.create!(name: 'Emre Surmeli', description: 'Emre is a software developer, a blockchain technology consultant, and an educator. Having gone through a full stack JavaScript boot camp in Seattle in 2015, he\'s passionate about accelerated learning programs and loves to take as well as teach them. Shortly after finishing his boot camp he worked at a tech startup building apps using node.js, Ruby/Rails, and AWS until October of 2018 when he decided to quit and try out digital nomad\'ing in Central America. He was introduced to Ethereum by his co-worker in late 2016, since then he spent most of his free time learning and researching about blockchain technologies and how to develop them. In the excitement of quickly realizing the imperative and inevitable role of blockchain in advancing specific technologies, he developed a blockchain workshop for GA. Emre has been combining his experience in web development and understanding of blockchain technologies to helping companies build blockchain applications.', link: 'https://www.linkedin.com/in/emresurmeli', photo: 'https://ga-core.s3.amazonaws.com/production/uploads/instructor/image/19535/thumb_2wdvr76.png')
Instructor.create!(name: 'Steve VanWoerkom', description: 'Steven VanWoerkom is a Instructor Lead at General Assembly New York City. A passionate technologist, educator, and lifetime learner who loves guiding students on their career paths to becoming web developers.', link: 'https://www.linkedin.com/in/steven-vanwoerkom', photo: 'https://ga-core.s3.amazonaws.com/production/uploads/instructor/image/18780/thumb_2uzxc85.jpg')
Instructor.create(name: 'Joe Keohan', description: 'Joe always had a passion for technology and after several years in the industry made the move into teaching Microsoft’s Server, Active Directory, and Sharepoint architectures. After working on a client project that involved Tableau and JavaScript, he was inspired to take GA’s Web Development Immersive Boot Camp where he made the decision to specialize in Data Visualization using D3.js. Upon graduation he worked on several D3 specific client projects before returning to GA as an instructor teaching their Front End Web Development and JavaScript evening classes. This ultimately led him into his current role as Lead Instructor for the WDI Bootcamp. He now spends his free time learning all things D3 while encouraging students to incorporate it into every project.', link: 'https://www.linkedin.com/in/jkeohan', photo: 'https://ga-core.s3.amazonaws.com/production/uploads/instructor/image/7866/thumb_headshot_gtt4a1.jpg')

puts "#{Instructor.count} instructors created!"
```

</details>


Now we can we can this seed data with this command in terminal:

```bash
$ rails db:seed
```

Let's check it out in the Rails console again. Cool? Cool.

### Creating the `index` and `show` methods in the controller

We have to do a couple of things before we can actually get around to sending back JSON data.

First, let's set up our routes. For today, we are only worried about Read All and Read One, so let's do this in our `config/routes.rb` file.

```rb
# we could restrict this to only Read methods by adding
#`, only [:index, :show]` at the end of `resources :teachers`
resources :instructors
```


Then, of course, we need to make a controller.

```sh
rails g controller instructors
```

Now let's work on the `index` and `show` methods -- since we haven't made a frontend, we'll just be visiting URLs and getting JSON.

<details>
<summary>Here's a controller with some error handling.</summary>

```rb
class InstructorsController < ApplicationController
  def index
    @instructors = Instructor.all
    render json: { message: "ok", instructors: @instructors }
  end

  def show
    begin
      @instructor = Instructor.find(params[:id])
      render json: { message: "ok", instructor: @instructor }
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'no instructor matches that ID' }, status: 404
    rescue StandardError => e
      render json: { message: e.to_s }, status: 500
    end
  end

end
```

</details>

### SIDEBAR: Error handling!

You may notice that the `show` method has some error handling built in. It's using a `begin`, `rescue`, (`ensure`), `end` block. Here's how that works:

```rb
begin
  # try to do this thing
rescue NameOfError
  # if there's an error that has this name, do this thing
rescue Exception
  # catch other errors. doing this actually isn't
  # super recommended -- it's better to see exactly what
  # errors you might get and handle them specifically.
ensure
  # anything after ensure will always be done, no matter how
  # many errors happen.
end
```

[Here's a blog post about it.](http://vaidehijoshi.github.io/blog/2015/08/25/unlocking-ruby-keywords-begin-end-ensure-rescue/)

Something similar exists in JavaScript: the `try`/`catch`/`finally` syntax.

```js
try {
  // tryCode - Block of code to try
} catch (err) {
  // catchCode - Block of code to handle errors
} finally {
  // finallyCode - Block of code to be executed
  // regardless of the try / catch result
}
```

[Here's a link to the MDN docs.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/try...catch)

# Part two: Hooking Rails up to React!

Since we aren't using views anymore, we need something else to handle the front end interface. What's better than using React? (Nothing. React is the **best**.)

Setting Rails up to work with React is a multi-step process -- similar to setting it up with Express, but there's a couple extra things we need to do, some extra tools, so on and so forth. Most of the tutorials out there have unnecessary steps, or outdated steps, or what have you, so let's walk through this together.

### Creating the React app!

Just like in Express, the React app in a React/Rails setup should be generated with `create-react-app`. (NOTE: There are a couple of gems like `react-rails` and `react-on-rails`. **DO NOT USE THEM. THEY ARE NOT WORTH IT.**)

In the root directory of the Rails app, type `create-react-app client`.

### Installing Cors in rails

Right now, if we were to make any api fetch calls from React to our api, we would be blocked by Cors.
To get around this, we need to configure Cors in our backend api.

In our `Gemfile`, we need to uncomment `gem 'rack-cors'`

Now we can install the package by running in terminal:
```
bundle install
```

Be sure to run this command in the root directory of our repo

### Configuring Cors

The Cors config file can be found in `/config/initializers/cors.rb`
In this file we need to uncomment a block of code that looks like this:

```rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'example.com'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

This currently allows `:any` header on all ('*') resources in our routes. It also allows the methods `:get, :post, :put, :patch, :delete, :options, :head`.
But also notice that it only allows these from the origin site of `example.com`.
THis is not what we want. We will be sending requests from localhost during developement and from our surge url after deployment. We correct this by changing `'example.com'` to `'*'`. This will allow any url to send requests to our api.

```rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

Now our api is all setup for Show All and Show One. We can go ahead and run:

```
rails s
```

### Let's Build the React App

```js
npx create-react-app client
```

Now cd into `client`, and try spinning up the react server with 

```
npm start
```

You should see this error:

```
Something is already running on port 3000
```

Our rails server is already using port 3000; we need to assign a different port for our react app; to do this, add `PORT=3001` to the beginning the "start" command in the package.json, like so:

```json
"start": "PORT=3001 react-scripts start", 
```

We are going to use React Router and Axios. Let's install them:

```sh
npm install react-router react-router-dom axios
```

<details>
<summary>Here is your <code>App.jsx</code></summary>

```jsx
import React, { Component } from 'react';
import { BrowserRouter as Router, Route, Link, Switch } from 'react-router-dom';
import axios from "axios";

import './App.css';

class App extends Component {
    state = {
      instructors: [],
      selectedInstructor: null
    }
  

  componentDidMount() {
    axios.get('http://localhost:3000/instructors')
    .then((response) => {
      this.setState({
        instructors: response.data.instructors,
      })
    })
  }

  selectInstructor = (instructor) => {
    this.setState({
      selectedInstructor: instructor
    })
  }

  instructors = () => {
    return this.state.instructors.map(instructor => (
      <div key={instructor.id}>
        <Link to={`/instructors/${instructor.id}`} onClick={() => this.selectInstructor(instructor)}>{instructor.name}</Link>
        <hr />
      </div>
    ))
  }

  instructor = () => {
    const instructor = this.state.selectedInstructor
    return (
      <div>
        <img alt={instructor.name} src={instructor.photo} width="20%"/>
        <h1>{instructor.name}</h1>
        <p>{instructor.description}</p>
        <a href={instructor.link}>Connect</a>
      </div>
    )
  }

  render() {
    return (
      <Router>
        <div>
          <Link exact="true" to='/'>Course App</Link>
        <Switch>
          <Route
            exact path="/"
            render={this.instructors}
          />
          <Route
            exact path="/instructors/:id"
            render={this.instructor}
          />
        </Switch>
        </div>
      </Router>
    );
  }
}

export default App;
```

</details>

## Deploy Rails & React App

Deploy backend Rails server to Heroku:

- `heroku create app_name`
- `git push heroku master`
- `heroku run rails db:migrate`
- `heroku run rails db:seed`
- `heroku open` to take us to the url link for our backend server.

Deploy frontend React to surge:

- replace `http://localhost:3000` on line 18 of our App.js with a link to our heroku backend server.
in terminal:
- `cd client`
- `npm run build`
- `cd build`
- `mv index.html 200.html`
- `surge`
- follow the prompts to get the link to the deployed site.

## Bonus: Refactor

1. Refactor the react methods for instructors() and instructor() into their own seperate components.
1. Notice that when you refresh the page for /instructors/:id, it breaks. Why is this? How can that be fixed?

