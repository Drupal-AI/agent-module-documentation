# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No module dependencies, and no third-party Composer or PHP libraries. It works with
  core's own user module.

## Install with Composer

From the project root:

```bash
composer require drupal/nocurrent_pass -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nocurrent_pass -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nocurrent_pass -y
```

> **Heads up:** the module ships with the requirement **already disabled**. As soon as
> you enable it, the "Current password" prompt is removed on the user edit and
> change-password forms (except for user 1). If you don't want that, untick the setting
> on the account settings form — see [Configuration](../configuration/index.md).

## Verify it worked

As a non-admin test user (not user 1), go to your account edit form and try changing
your email or password. The **Current password** field should be absent. To restore
the requirement, visit **Configuration → People → Account settings**
(`/admin/config/people/accounts`) and untick **Do not require current password**.
