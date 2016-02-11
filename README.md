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

username:string [present]
email:string 	[present]
password:string [present]

has_many posts
has_many comments

### Post

title:string 	[present]
body:text 		[present]
user_id:integer 

has_many comments
belongs_to user

### Comment

body:text 		[present]
user_id:integer 
post_id:integer 

belongs_to user
belongs_to post

## From the command line, run:

- rails new micro-reddit

After you create new direcotry, change into that directory from the command line:

- cd micro-reddit

## Create a User Model

- rails generate model User username:string email:string password:string

Check the micro-reddit/db/migrate/ folder to confirm migration file was created