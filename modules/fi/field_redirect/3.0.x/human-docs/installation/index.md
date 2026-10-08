# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or newer.

There are no other module dependencies and no third‑party libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/field_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_redirect -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Search and metadata →
Field Redirect** (`/admin/config/search/field-redirect`). You should see the
redirect rules text area. Add a rule (see [Configuration](../configuration/index.md)),
save, then open a matching entity — it should redirect to the field's URL.
