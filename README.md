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

Framework Requirements
----------------------

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

- store data in a MySQL database (InnoDB)
  Because we need to have an RDMS (suporting ACID). In a real world application, this would be or primary source but we won't get data directly from this data store

- read data from a redis server
  Because we need performance.

_Notes:_
- _The software we chose are totally arbitrary but we need to have exactly the same for each framework because we want to check frameworks in the same conditions_
- _In future version, we must ensure that the framework is able to handle more HTTP verbs: POST, PUT, PATCH, DELETE_


Each project needs to provide a `build.sh` file in the framework root dir.
This file will be run before we test the application. It should bootstrap your application by creating some docker container.
If you are not familiar with docker, don't worry. You can open a pull request with the framework you want to test and we'll try to make it work for you.

