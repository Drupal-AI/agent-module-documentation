# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Redirect** module (`redirect`) — the module this one imports into.
- Core's **Database Logging** module (`dblog`) — used to log import activity.

Both dependencies are enabled automatically when you enable this module. Note that
Import redirect JSON is **not covered by Drupal's security advisory policy** — keep
its permission restricted to trusted administrators.

## Install with Composer

From the project root:

```bash
composer require drupal/import_redirect_json -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This will pull in the Redirect module if it is not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/import_redirect_json -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en import_redirect_json -y
```

## Verify it worked

Go to **Configuration → Search and metadata → URL redirects** and confirm the
**Import redirect JSON** screens are present — a **Mapping** page at
`/admin/config/search/redirect/import-redirect-json/mapping` and an import page at
`/admin/config/search/redirect/import-redirect-json`. See
[Configuration](../configuration/index.md) to map your fields and run an import.
