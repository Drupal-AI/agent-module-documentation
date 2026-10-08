# Installation

## Requirements

HTTP Status Code is lightweight and has no third‑party dependencies:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No additional contrib modules and no PHP library requirements.

Note that this project is **not covered by Drupal's security advisory policy**
and is currently *Seeking new maintainer*. Weigh that before using it on a
high‑stakes production site.

## Install with Composer

From the project root:

```bash
composer require drupal/http_status_code -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_status_code -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_status_code -y
```

Managing mappings requires the **Administer HTTP status code**
(`administer http status code`) permission, which you grant at **People →
Permissions**. Give it only to trusted administrators.

## Verify it worked

Go to **Configuration → HTTP Status Code**
(`/admin/config/http_status_code/http_status_entity`). You should see an empty
list of status mappings and an **Add** button. Create one test mapping (for
example a throwaway path returning `410`), request that path in your browser or
with `curl -I`, and confirm the response carries the status code you chose. See
[Configuration](../configuration/index.md) for the full walkthrough.
