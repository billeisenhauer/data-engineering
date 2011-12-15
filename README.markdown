# Challenge for Software Engineer - Big Data 
To better assess a candidates development skills, we would like to provide the following challenge.  You have as much time as you'd like (though we ask that you not spend more than a few hours) and may use any programming language or framework you'd like.  

There are three jobs that both use this challenge:

1. Senior Software Engineer: If you are applying to this position, the email address you should use for submission is [dev.challenges@livingsocial.com](dev.challenges@livingsocial.com).
1. Associate Developer: If you are applying to this position, the email address you should use for submission is [dev.challenges@livingsocial.com](dev.challenges@livingsocial.com).
1. Senior Software Engineer, Big Data (and/or Data Scientist): If you are applying to this position, the email address you should use for submission is [data.challenge@livingsocial.com](mailto:data.challenge@livingsocial.com).

Feel free to email the appropriate address above if you have any questions.

## Submission Instructions
1. First, fork this project on github.  You will need to create an account if you don't already have one.
1. Next, complete the project as described below within your fork.
1. Finally, push all of your changes to your fork on github and submit a pull request.  You should also email the appropriate address listed in the first section and your recruiter to let them know you have submitted a solution.  Make sure to include your github username in your email (so we can match people with pull requests).

## Alternate Submission Instructions (if you don't want to publicize completing the challenge)
1. Clone the repository
1. Next, complete your project as described below within your local repository
1. Email a patch file to the appropriate address listed above ([data.challenge@livingsocial.com](mailto:data.challenge@livingsocial.com) if you are applying for the Big Data position, [dev.challenges@livingsocial.com](dev.challenges@livingsocial.com) if you are applying for the general Senior Software Engineer or Associate Developer position).

## Project Description
Imagine that LivingSocial has just acquired a new company.  Unfortunately, the company has never stored their data in a database and instead uses a plain text file.  We need to create a way for the new subsidiary to import their data into a database.  Your task is to create a web interface that accepts file uploads, normalizes the data, and then stores it in a relational database.

Here's what your web-based application must do:

1. Your app must accept (via a form) a tab delimited file with the following columns: purchaser name, item description, item price, purchase count, merchant address, and merchant name.  You can assume the columns will always be in that order, that there will always be data in each column, and that there will always be a header line.  An example input file named example_input.tab is included in this repo.
1. Your app must parse the given file, normalize the data, and store the information in a relational database.
1. After upload, your application should display the total amount gross revenue represented by the uploaded file.

Your application does not need to:

1. handle authentication or authorization (bonus points if it does, extra bonus points if authentication is via OpenID)
1. be written with any particular language or framework
1. be aesthetically pleasing

Your application should be easy to set up and should run on either Linux or Mac OS X.  It should not require any for-pay software.

## Evaluation
Evaluation of your submission will be based on the following criteria:

1. Did your application fulfill the basic requirements?
1. Did you document the method for setting up and running your application?
1. Did you follow the instructions for submission?

## Solution Overview
A few notes on the solution:

1. Two kinds of authorization: database (through registration) and through Google Account OpenID.
1. Due to the long URLs required by the OpenID scheme, Webrick has been swapped out for Thin.
1. The project description hints at normalizing the data and yet the data is mostly ill-suited to it.  However, I've attempted to normalize it, but doing so created some peculiarities.
1. Customers are the purchaser, but are unique by name; thus a new customer is added every time a new name is encountered.
1. The same is true of Merchants.
1. Products are unique by description, but scoped to the merchant.
1. Each line of data represents an Order with one Order Line Item.  However, Orders can handle more than one line item. 
1. The upload processing is deferred to an asynchronous job; using Delayed Job.
1. The result of processing is not immediately available after upload; a refresh link is provided to get the total.
1. No handling is provided for failed jobs; this is a robustness probably beyond the intended scope of this project.
1. There is ample test coverage, but not 100% test coverage; only enough to demonstrate RSpec familiarity.

## Set up
After cloning the project, you'll want to follow these instructions to get bootstrapped.

Consider using rvm where you can use Ruby 1.9.2 and a custom gemset for the project.  My .rvmrc contains the following:

ruby-1.9.2-p290@lschallenge

If you use rvm or something similar, you will have to bootstrap your gems.  You'll need to follow a command sequence similar to this:

1. rvm gemset create 'lschallenge'
1. gem install bundler
1. bundle install

In one terminal window, run the following commands:
 
1. rake db:schema:load
1. rake db:test:prepare
1. rake spec
1. thin start

NOTE: running specs (step 3) is optional, but its comforting to know that the running system will likely work.

In another terminal window, run the following:

1. rake jobs:work

## Usage
Its self-explanatory for the most part, but here's some usage notes:

1. In the browser, go to:  http://localhost:3000
1. Choose to Sign Up or Sign in through Google
1. Upon sign in, you'll be redirected to the import page where you can import a file
1. Uploads are processed asynchronously, so you'll have to refresh the page after the import to see the total

Yes, I could have added some Javascript to auto-refresh a certain number of times so that you could have just sat and watched the page.  Sorry, I didn't.

