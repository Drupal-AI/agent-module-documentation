# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9.0`).

There are no other module dependencies and no third-party PHP libraries to
install.

> **Use on development only.** Schema Diff is a developer/diagnostic tool that
> exposes database structure. It is *not* covered by Drupal's security advisory
> policy and, at the time of writing, is an alpha release. Install it on a
> development or staging site to debug mismatches — not on production.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_diff -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_diff -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_diff -y
```

## Verify it worked

Visit **Reports → Status report** (`/admin/reports/status`). If your site has any
mismatched entity/field definitions, the mismatch section will now include a
detailed, per-field diff table provided by this module. When you are done
debugging, uninstall the module.
