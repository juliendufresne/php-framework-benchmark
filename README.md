PHP (micro) Framework Benchmark
===============================

**Pull Requests are more than welcome !**

This project aims to test every known PHP framework against the same requirements.
When it comes to select a (micro-)framework, we usualy base our choice on:
- Performance
- The community around the framework
- Number of librairies
- Ease of development
- Project's developers taste

So performance is one of the criteria to pick a framework.
In our case, we'll assume to work in a microservice architecture.
Our projects will be small and will not require a lot of things to work.
The best choice will probably be a microframework because of the size of each project but we have to test fully featured framework as well.

The Stack
---------

A framework rarely works alone. It needs to connect to one (or more) database(s), send emails, ...
We need to check frameworks in the same conditions. This means we need to use the same software in every framework.
_You may think that the choice we made are not the best tools but it's not the purpose of this project_

Here is the stack we've selected:
1. MySQL as a primary data store. Data will be saved in MySQL but we won't read directly from it except during data alteration
2. RabbitMQ as messaging system. It will be used to handle modification asynchronously
3. Redis will be use as a cache server. We'll read data directly from it and fallback to MySQL if the data is not found.
   We could have use it as a message broker but we need to ensure that the framework under test can connect to multiple tools and personaly I like to have tools dedicated to one task only.

We can add other tools (a search engine, an email server, monitoring tools) but let's focus and this stack for the moment.

Functional specifications
-------------------------

In order to compare framework against each other, each project must fullfil the same requirements:
- Respond to this HTTP requests:
  This part will ensure that the framework is able to respond to both json and html format and add custom header

  | Description |  Request    | Response Header | Response |
  |-------------|-------------|-----------------|----------|
  | get one user by email | TBD | TBD | TBD |
  | list all users     | [html](docs/http/get_users/request.html.txt) - [json](docs/http/get_users/request.json.txt) | [html](docs/http/get_users/response-header.html.txt) - [json](docs/http/get_users/response-header.json.txt) | [html](docs/http/get_users/response.html) - [json](docs/http/get_users/response.json) |
  | paginate users     | [html](docs/http/paginate_users/request.html.txt) - [json](docs/http/paginate_users/request.json.txt) | [html](docs/http/paginate_users/response-header.html.txt) - [json](docs/http/paginate_users/response-header.json.txt) | [html](docs/http/paginate_users/response.html) - [json](docs/http/paginate_users/response.json) |

- Consume an AMQP queue:
  We should be able to create, edit and remove a resource asynchronously

  | Queue name          | Queue format                      | Description                             |
  | ------------------- | --------------------------------- | --------------------------------------- |
  | create_user         | [body](docs/amqp/create_user.json) | Create a user                           |
  | edit_user_firstname | [body](docs/amqp/edit_user.json)   | Edit user's firstname (search by email) |
  | remove_user         | [body](docs/amqp/remove_user.json) | Remove a user (search by email)         |

_Notes:_
- _The software we chose are totally arbitrary but we need to have exactly the same for each framework because we want to check frameworks in the same conditions_
- _In future version, we must ensure that the framework is able to handle more HTTP verbs: POST, PUT, PATCH, DELETE_

Installation requirements
-------------------------

In order to be able to build the framework, you need to provide a `build.sh` file in the framework root dir.
Ideally, it should run some docker containers to make your application testable in the same condition as other framework.
If you are not familiar with docker, simply describe how the framework should be built and we'll try to create docker containers for you.

