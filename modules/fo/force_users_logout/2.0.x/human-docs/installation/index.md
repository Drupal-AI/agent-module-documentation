# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other contrib modules, Composer libraries or PHP extensions are required.

Access to the forms is controlled by core's built-in **Administer users**
permission, which administrators already have. The module adds no permission of
its own.

## Install with Composer

From the project root:

```bash
composer require drupal/force_users_logout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/force_users_logout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en force_users_logout -y
```

There is no configuration to save — the module is ready to use as soon as it is
enabled.

## Verify it worked

Log in as a user with the **Administer users** permission and go to
**Configuration → Development → Force users logout settings**
(`/admin/config/force-users-logout/individualuser`). You should see a page with
three tabs: **Individual User**, **Role Based** and **All Other Users**. See
[Configuration](../configuration/index.md) for what each one does.
