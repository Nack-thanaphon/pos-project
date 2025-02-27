# POS Application

This repository contains the code for a Point-of-Sale (POS) application. The project is divided into multiple repositories and includes a database schema, API, and frontend application.
![POS System Architecture](/logo.png)


## Repositories

- [POS Project](https://github.com/Nack-thanaphon/pos-project.git)
- [POS API](https://github.com/Nack-thanaphon/pos-api.git)
- [POS WEB](https://github.com/Nack-thanaphon/pos-web.git)

## Getting Started

### Cloning the Repositories

To clone the repositories and update submodules, run the following commands:

```sh
git submodule update --remote --recursive
git pull --recurse-submodules
```

## Start up (PRODUCTION)

### directory : pos-project
#### change env.local to .env
```sh
make up
```
## Setting Up the Database (DEVELOPMENT)

### directory : pos-project

```sh
make stack
```

## Setting Up the Start Application (DEVELOPMENT)

### directory : pos-app

```sh
cd pos-app
make dev
```
## API DOCUMENT(DEVELOPMENT)

```sh
localhost:3001/document

username : admin
password : 123456
```

### DEVELOPER

```sh
Thanaphon Kallapapruek
## Full-stack Developer @LivingInsider
## Full-stack Mentor @Westride
```
