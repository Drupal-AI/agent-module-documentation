# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Translation Management Tool** module (`tmgmt`) and its content source
  **TMGMT Content** (`tmgmt_content`) — together these produce the translation
  jobs and field lists that this module filters.

There are no additional PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_ignore_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TMGMT and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_ignore_fields -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_ignore_fields -y
```

TMGMT and TMGMT Content are enabled automatically as dependencies if they are not
already on.

## Verify it worked

Visit **Configuration → Content authoring → TMGMT Ignore Fields**
(`/admin/config/content/tmgmt-ignore-fields`). If the settings form loads and
lists the fields on your site, the module is ready — head to
[Configuration](../configuration/index.md) to choose what to exclude.
