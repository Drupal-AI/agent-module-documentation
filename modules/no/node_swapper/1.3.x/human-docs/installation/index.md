# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Redirect** module (`redirect`) — used to create the old→new redirects.
- The **Pathauto** module (`pathauto`) — used to manage URL aliases.

Both dependencies are contributed modules; Composer pulls them in for you when you
require Node Swapper below.

## Install with Composer

From the project root:

```bash
composer require drupal/node_swapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Redirect and Pathauto
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_swapper -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_swapper -y
```

Enabling Node Swapper also enables Redirect and Pathauto if they are not already on.

## Verify it worked

Log in as an administrator, then go to **Configuration → System → Node Swapper**
(`/admin/config/system/node-swapper`). You should see the swap tool. Remember to
grant the **Access Node Swapper** and **Administer Node Swapper** permissions to the
roles that need them — see the "How to use it" section of the
[overview](../index.md).
