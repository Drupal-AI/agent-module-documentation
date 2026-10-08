# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No other modules are required. To make full use of it you'll want access to the
  external JavaScript files you're securing and a way to generate SRI hashes (a
  free tool such as `srihash.org` works well).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/external_script_sri -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_script_sri -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_script_sri -y
```

## Verify it worked

Grant the **Administer External Script SRI** permission to your administrator role
at **People → Permissions**, then visit **Configuration → System → External Script
SRI** (`/admin/config/system/sri-configuration`). The management form should load,
ready for you to add external scripts. See
[Configuration](../configuration/index.md) for how to fill it in.
