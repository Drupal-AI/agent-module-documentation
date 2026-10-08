# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — the only dependency.

There are no additional PHP library requirements of its own. Some example
pipelines also use the optional **Migrate Conditions** module
(`drupal/migrate_conditions`) for `skip_on_condition` with `matches` — install
that only if your migration needs it.

> **Security coverage:** this module's releases are **not covered** by Drupal's
> security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_process_html -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_process_html -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_process_html -y
```

Core Migrate is enabled automatically if it is not already on.

## Verify it worked

Confirm the module is enabled (**Extend** page, or
`drush pm:list --status=enabled`). There is no settings form to check — the
`migrate_process_html` process plugin becomes available for use in your migration
YAML (see "How to use it" on the [overview page](../index.md)).
