# The Odin Project - micro-reddit walkthrough

11 February 2016
Estimated Time: 2 hrs

Course: Ruby on Rails >> Databases and Active Record >> Project: Building With Active Record

## Objective:

Let's build Reddit. Well, maybe a very junior version of it called micro-reddit. In this project, you'll build the data structures necessary to support link submissions and commenting. We won't build a front end for it because we don't need to... you can use the Rails console to play around with models without the overhead of making HTTP requests and involving controllers or views.

# Basic Steps

## Get Started

Just like in the warmup, plan out what data models you would need to allow users to be on the site (don't worry about login/logout or securing the passwords right now), to submit links ("posts"), and to comment on links. Users do NOT need to be able to comment on comments... each comment refers to a Post.

## Database Structure

### User

- username:string 	[unique, 25 chars max,  present]
- email:string 		[unique, 255 chars max, present]
- password:string 	[6 chars min, present]

- has_many posts
- has_many comments

### Post

- title:string 		[present]
- body:text 		[present]
- user_id:integer 

- has_many comments
- belongs_to user

### Comment

- body:text 		[present]
- user_id:integer 
- post_id:integer 

- belongs_to user
- belongs_to post

## From the command line, run:

- rails new micro-reddit

After you create new direcotry, change into that directory from the command line:

- cd micro-reddit

## Create a User Model

- rails generate model User username:string email:string password:string

Check the micro-reddit/db/migrate/ folder to confirm migration file was created

Run the migration with 

- rake db:migrate

## Working with the Model in the Console

From the rails console. Try asking for all the users with

- User.all

You should get back an empty array

create a blank new user and store it to a variable with

- u = User.new

Check if record is valid:

- u.valid?

Implement the user validations you thought of in the first step 

- in app/models/user.rb

Reload the console, and confirm that your validations are working:

- reload!

Build another new user but don't save it yet 

- u2 = User.new 

- u.valid? 

This time the validations should come up false, so we can't save to the database

We need to find out what went wrong, Rails is helpful because it actually attaches error messages directly onto your user object when they fail validations. Issue the follow command and it will return a nice friendly array of messages using the #errors.full_messages method:

- u2.errors.full_messages

## Create a user and save it to User table in one go:

- u3 = User.create(username: "Example User", email: "user@example.com", password: "foobar")