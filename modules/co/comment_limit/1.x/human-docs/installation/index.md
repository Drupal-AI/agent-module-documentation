# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Comment** module enabled, since the limit applies to a comment field.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/comment_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comment_limit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comment_limit -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to set a limit
on one of your comment fields and to grant the permission the module adds. To test,
set a low limit, then post comments as a non‑privileged user until you reach the
cap — further submissions should be blocked.
