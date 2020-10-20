Reward System
=========

## Development Environment

__Services Required for Development Environment:__
- Git 2.17.2
- ruby 2.5.3
- Bundler 2.0.2
- Sinatra 2.0.7


__Instructions for Installing Development Environment Services on Ubuntu / Mac OSX:__

- Install [RVM From here](https://rvm.io/rvm/install)
- We can also use rbenv based on your choice, for both installation refferences visit [go rails site](https://gorails.com/setup/)


- Install ruby 2.5.3

		rvm install ruby-2.5.3

__Setup the Development Environment:__

- Clone the git repository

		git clone https://gitlab.com/rvk0106/reward_system.git

		cd reward_system

        



__Running the application locally:__

- Run the Web Server using the built in Sinatra. To run, use following command which handle testing documentation and server startup

		# within the Reward System folder
		chmod 777 startup.sh && ./startup.sh

	Visit [http://localhost:4567](http://localhost:4567) to access the local development environment.
	Visit [http://localhost:4567/doc/index.html](http://localhost:4567/doc/index.html) for technical documentation.
	Visit [http://localhost:4567/coverage/index.html#_AllFiles]
	(http://localhost:4567/coverage/index.html) 
	
	for Simple cov test coverage details.
    

__LOCAL Environment Testing__  

Run unit tests:  
`bin/bundle exec rspec`

The test coverage of code is as shown below

![https://gitlab.com/rvk0106/reward_system/raw/master/public/coverage.png](https://gitlab.com/rvk0106/reward_system/raw/master/public/coverage.png)
![http://localhost:4567/coverage.png](http://localhost:4567/coverage.png)
 	
Visit [http://localhost:4567/coverage/index.html#_AllFiles](http://localhost:4567/coverage/index.html)
	  
for Simple cov test coverage details.
## Ruby tree Manifesto

Visit http://rubytree.anupamsg.me/rdoc/Tree/TreeNode.html for documentation


## Problem statements and assumptions made
With refference to the below problem statement I have assumed certain statements:


1. The input will be in the following formate and any other formates will not be allowed.
    
        "2018-06-12 09:41 A recommends B"
    
        "2018-06-14 09:41 B accepts"


2. Invitations will be processed based on the date and time.

3. If A recommends B in a given pirticuler date and time. If B accepts on the same time that is accepted.

4. The recommendations sent by customers will be ignored who didnt accepted the invitation that they recived. 
    Only after accepting the invitation they are allowed to send recommendation.

5. If a new recommendation comes from a user without having invitation then he will be considered as direct customer.


 
![http://localhost:4567/problem.png](http://localhost:4567/problem.png)
![https://gitlab.com/rvk0106/reward_system/blob/master/public/problem.png](https://gitlab.com/rvk0106/reward_system/raw/master/public/problem.png)


