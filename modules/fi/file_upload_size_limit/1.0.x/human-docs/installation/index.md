# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **File** module (`file`) — enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements. Note this is an
**alpha** release (`1.0.0-alpha7`) and is **not covered by Drupal's security
advisory policy** — and, in any case, the check is client-side only (see the
overview). Test before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/file_upload_size_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_upload_size_limit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_upload_size_limit -y
```

Per-file, in-browser size validation is active as soon as the module is enabled —
there is nothing you *must* configure. Adjust the multi-file total-size behavior on
the settings form only if you need it (see [Configuration](../configuration/index.md)).

## Verify it worked

On a form with a file field, try selecting a file larger than the field's configured
maximum. You should get an immediate in-browser warning before any upload takes
place, rather than waiting for the server to reject it. Remember this is front-end
feedback only — the server-enforced limits still apply and are what actually protect
the site.
