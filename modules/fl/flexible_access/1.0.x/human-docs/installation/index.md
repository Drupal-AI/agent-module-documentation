# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third-party Composer or PHP library requirements, and no other module
  dependencies — Flexible Access works with core's entity-access system.

> **Heads-up:** this is a **1.0.0-beta2** release and is **not covered** by the
> Drupal security advisory policy. Test your rules thoroughly before using it on a
> production site with sensitive content.

## Install with Composer

From the project root:

```bash
composer require drupal/flexible_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flexible_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flexible_access -y
```

## Verify it worked

After enabling, visit **People → Permissions** and confirm the Flexible Access
permissions appear. Then head to [Configuration](../configuration/index.md) to
define your first access rule — and, crucially, to test it against each role
before trusting it.
