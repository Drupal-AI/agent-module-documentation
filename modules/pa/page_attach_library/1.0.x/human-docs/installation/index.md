# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/page_attach_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_attach_library -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_attach_library -y
```

## Verify it worked

Go to **Configuration → Page Attach Library → Page Attach Library Settings**
(`/admin/config/page-attach-library/page-attach-library-settings`). You should see
the rules table. Continue to [Configuration](../configuration/index.md) to add a
rule, then load a matching page and confirm the library's CSS/JS is present in the
page source.
