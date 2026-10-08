# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **JSON:API Frontend** module (`jsonapi_frontend`) — this module is an add-on
  for it and depends on it. Composer pulls it in automatically.
- Drupal core's built-in menu system (always present).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_frontend_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including JSON:API Frontend — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_frontend_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_frontend_menu -y
```

Enabling it also enables JSON:API Frontend if it is not already on.

## Verify it worked

From a browser or with `curl`, call the menu endpoint for a menu you know exists
(the main menu is a safe first try):

```
GET /jsonapi/menu/main?_format=json
```

You should get back a nested JSON tree of the menu's links. Remember that only
links the current user can access are returned, so test as the role that will
actually consume the API. Add `?path=/some/page` to see the active-trail flags
appear on the matching links.
