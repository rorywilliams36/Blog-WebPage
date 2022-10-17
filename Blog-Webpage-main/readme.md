For each instruction run the code in the quotations "RUN THIS"

To install the code on your device do
"git clone https://git.shefcompsci.org.uk/com1001-2021-22/team01/project/"

Once installed navigate into the root folder of the project (project/)

If you are on Codio you will need to do ".codio/install" if you have not ran sinatra before else move to the next step

Next type in "bundle install" to run all the required gems in the Gemfile.

Now you have set everything up, type "sinatra" in the root to run the program

The page can be accessed via "localhost:4567/"

By default the users you can use to sign in/test the system are:

<b>NAME:PASSWORD</b>
admin:admin
moderator:moderator
reporter1:reporter1
reporter2:reporter2
viewer1:viewer1
viewer2:viewer2
suspendeduser:suspendeduser

We are aware the passwords do not match the security requirements set out however they are what was requested in the project brief.

Upon creating a new user there are requirements that need to be met for the data that will not have been met in the users above, please be aware of this when running the program.


<b><u>RSpec Tests</u></b>
To run the tests navigate into the root directory (projects/) and type "rspec spec"
