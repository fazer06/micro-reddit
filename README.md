# The Odin Project - micro-reddit walkthrough

11 February 2016
Estimated Time: 4 hrs (Including the these notes, and playing with it)

Course: Ruby on Rails >> Databases and Active Record >> Project: Building With Active Record

## Objective:

Let's build Reddit. Well, maybe a very junior version of it called micro-reddit. In this project, you'll build the data structures necessary to support link submissions and commenting. We won't build a front end for it because we don't need to... you can use the Rails console to play around with models without the overhead of making HTTP requests and involving controllers or views.

## Get Started

Just like in the warmup, plan out what data models you would need to allow users to be on the site (don't worry about login/logout or securing the passwords right now), to submit links ("posts"), and to comment on links. Users do NOT need to be able to comment on comments... each comment refers to a Post.

## Database Structure

### User

- username:string 	[unique, 25  chars max,  present]
- email:string 		[unique, 255 chars max,  present]
- password:string 	[6 chars min, present]

- has_many :posts
- has_many :comments

### Post

- title:string 		[present]
- body:text 		[present]
- user_id:integer 

- belongs_to :user
- has_many   :comments

### Comment

- body:text 		[present]
- user_id:integer   [present]
- post_id:integer   [present]

- belongs_to :user
- belongs_to :post

## Step 1 - Build the new app

### From the command line, run:

- rails new micro-reddit

After you create the new project, change into that directory from the command line:

- cd micro-reddit

## Step 2 - Create a User Model

- rails generate model User username:string email:string password:string

Check the micro-reddit/db/migrate/ folder to confirm the migration file was created

Run the migration with 

- rake db:migrate

### Working with the Model in the Console

From the rails console. Try asking for all the users with

- User.all

You should get back an empty array

create a blank new user and store it to a variable with

- u = User.new

Check if the record is valid:

- u.valid?

Implement the user validations you thought of in the first step 

in app/models/user.rb

- validates :username, presence: true, length: { maximum: 25 }, uniqueness: true

- validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
		   
- validates :password, presence: true, length: { minimum: 6 }

Reload the console, and confirm that your validations are working:

- reload!

Build another new user but don't save it yet 

- u2 = User.new 

- u.valid? 

This time the validations should come up false, so we can't save to the database

We need to find out what went wrong, Rails is helpful because it actually attaches error messages directly onto your user object when they fail validations. Issue the follow command and it will return a nice friendly array of messages using the errors.full_messages method:

- u2.errors.full_messages

### Create a user and save it to User table in one go:

- u3 = User.create(username: "Example User", email: "user@example.com", password: "foobar")

## Step 3 Create a Post Model

- rails generate model Post title:string body:text
- bundle exec rake db:migrate

### Setup the validations in models/post.rb

- validates :title, presence: true
- validates :body,  presence: true

### Test the validation from the console, remembering to reload! it between changes.

- p = Post.create(title: "Hello World", body: "My First Post")

### Next we need to include the foreign key column (user_id) in the posts table

- rails generate migration AddForeignKeyToPost user:references

The user:references argument will add a column with foreign key that references User model.
Check the db/migrate folder to make sure the new migration file is correct.
Run migration:

- bundle exec rake db:migrate

## Step 4: Set up the associations between User and Post models

In app/models/user.rb

- has_many :posts

In app/models/post.rb

- belongs_to :user

The above creates the relationship between Post and User models. All it is saying is,  a post belongs to a user, and a user can have many posts. This is known as a one-to-many relationship. With the associations properly set up we have a few more methods that we can use in the console, including finding a User's Posts, and finding the Post's User.

### Confirm the associations in console

At this point we have one User, and One Post in the database. However the Post in the database doesn't have a :user_id associated with it, so we'll correct that now with the following command. 

- post = Post.first
- post.update_attributes(user_id: 1)

### Create a new user

- user = User.create(username: "Odin", email: "odin@email.com", password: "foobar")

### Create a new post

- post = Post.create(title: "Second User Post", body: "A post to confirm the associations", user_id: 2)

### Confirm you can find the posts for given User (the has_many side of the relationship)

- user.posts

The has_many relationship between a user and its posts, returns a collection of the user’s posts

### Confirm you can find User for given post (the belongs_to side of the relationship)

- post.user

The belongs_to relationship between a post and its associated user, returns the User object associated with the post

## Step 5: Build Comment Model

### Generate the model with the following command

- rails generate model Comment body:text user:references post:references

### Run migration

- bundle exec rake db:migrate

## Step 6: Building Additional Associations

### In the app/models/comment.rb

- belongs_to :user
- belongs_to :post

These were generated automatically by the migration because we included user:references post:references

### In the app/models/post.rb

- belongs_to  :user
- has_many 	  :comments

### In the app/models/user.rb

- has_many :posts
- has_many :comments

## Step 7: Add Validations to Comment Model

- validates :body, presence:true
- validates :user, presence:true
- validates :post, presence:true

## Testing in the console

### Comment validation

Create a new comment with some body text and try to save it without a user_id and a post_id

- c = Comment.create(body: "That was a really good post!")
- c.valid?
- c.errors.full_messages

The output from errors.full_messages is ... ["User can't be blank", "Post can't be blank"]

At this point in my application i have two users with id:1 and id:2 and I also have two posts, one made from each user. Next i'm going to create a comment form the user with the id:2 who is making a comment on the post with the id:1  (that was made by the user with the id:1)

### Run the command a second time but this time add a user_id and post_id to the comment.

- c = Comment.create(body: "That was a really good post!", user_id: 2, post_id: 1)

### Check if you can find comments from User and Post objects

Comes from the User has_many :comments side of the relationship
- u = User.find(2).comments

Comes from the Post has_many :comments side of the relationship
- p = Post.find(1).comments

## Step 8: Check for valid associations in Console

## Make sure everything is working as we would expect between the User, Post, and Comment models.

### Find user 2
- u2 = User.find(2)

### Should return that user's comment
- c1 = u2.comments.first

### Should return that comment's author User (u2)
- c1.user

### Should return the first post
- p1 = Post.first

### Should return the comment (c1)
- p1.comments.first

### Should return the post (p1)
- c1.post

# Further reading on models and relationships
- http://tutorials.jumpstartlab.com/topics/models/relationships.html