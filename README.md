flamingo for Gumtree coding challenge
=====================================


## How I sorted out "The task"

The application is composed of three maven modules. The first is a simple POM container (flamingo) which contains two submodules:

1. mysql module - conteins the model, the repository and the service related to the model (the service layer is not actually used)

2. mvc module - this module contains the restfull webservice (not actually used) and a controller that manages the index view and the upload action

## The application
The application has been scaffolded with spring roo which offers a fast and consistent way of structuring maven multi module applications.
To run the application. Clone it

```
git clone https://github.com/davidecavaliere/flamingo.git
```

enter the directory flamingo/mvc

```
cd flamingo/mvc
```

and type

```
mvn jetty:run
```

point your browser to http://localhost:8080

an example file to upload can be found in flamingo/mysql/src/test/resources/dummydata.csv

