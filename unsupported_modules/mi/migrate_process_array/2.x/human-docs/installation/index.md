# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Migrate** module must be enabled to run migrations — the process
  plugins operate within the Migrate framework.

The module declares no additional module dependencies and no third‑party PHP
libraries of its own.

> **Security coverage:** this module's releases are **not covered** by Drupal's
> security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_process_array -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_process_array -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_process_array -y
```

Make sure core Migrate is enabled as well so your migrations can run.

## Verify it worked

Confirm the module is enabled (**Extend** page, or
`drush pm:list --status=enabled`). There is no settings form to check — the
`array_intersect` and `array_diff` process plugins become available for use in
your migration YAML (see "How to use it" on the [overview page](../index.md)).
