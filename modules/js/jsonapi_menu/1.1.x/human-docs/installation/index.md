# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu Link Content** module (`menu_link_content`).
- The contributed **JSON:API Resources** module
  (`jsonapi_resources`), on which the endpoint is built.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including JSON:API Resources — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_menu -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_menu -y
```

Drupal enables Menu Link Content and JSON:API Resources as dependencies if they
are not already on.

## Verify it worked

Request a menu you know exists, for example the main menu:

```
GET /jsonapi/jsonapi_menu/main
```

You should get back the menu together with its nested items. Try `footer` or
another menu's machine name to confirm other menus resolve too.
