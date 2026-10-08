# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **Webform** module (`webform`) — the forms this add-on resolves.
- The **JSON:API Frontend** module (`jsonapi_frontend`) — this is an add-on for
  it and depends on it.

Composer pulls both dependencies in automatically. There are no third‑party PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_frontend_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including JSON:API Frontend and Webform — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_frontend_webform -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_frontend_webform -y
```

Enabling it will also enable Webform and JSON:API Frontend if they are not already
on.

## Verify it worked

Configure JSON:API Frontend first (see its own settings at
`/admin/config/services/jsonapi-frontend`), then resolve a Webform path through
`/jsonapi/resolve`. A path such as `/contact` (aliased to `/form/contact`) should
resolve as **non-headless** and return a `drupal_url` pointing back at Drupal — the
signal your front end uses to proxy or redirect the visitor to the real form. A
restricted form should resolve as "not found".
