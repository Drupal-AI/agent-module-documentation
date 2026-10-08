# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Update** module (`update`) — supplies the version and update-status
  data the endpoint reports.
- Core's **Basic Auth** module (`basic_auth`) — provides the HTTP basic
  authentication the endpoint uses.

Both dependencies ship with Drupal core; Drupal will enable them automatically as
needed. There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/edw_healthcheck -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/edw_healthcheck -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edw_healthcheck -y
```

Drupal will enable the Update and Basic Auth modules as dependencies if they are
not already on.

## Verify it worked

Create the monitoring account and grant it the **EDW healthcheck access**
permission (see the main guide's "How to use it"), then request
`/edw_healthcheck/{type}` over HTTPS with that account's basic-auth credentials.
You should receive a JSON document describing the site's status. Confirm the same
request **without** credentials is rejected — that tells you the endpoint is not
exposing your version inventory anonymously.
