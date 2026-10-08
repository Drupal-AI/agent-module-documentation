# Installation

## Requirements

Hello World REST needs core's REST module:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **RESTful Web Services** module (`rest`) — the only dependency, which
  Drupal enables automatically when you turn on this module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/helloworld_rest -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/helloworld_rest -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en helloworld_rest -y
```

Core's `rest` module comes along automatically as a dependency.

## Verify it worked

Once the module is enabled, expose the example resource and grant its **GET**
permission (see "How to use it" on the [overview page](../index.md)), then make a
request to the endpoint. Receiving the sample response confirms everything is
wired up.
