# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- These modules enabled (Composer pulls the contrib one in for you):
  - **[Views Bulk Operations](https://www.drupal.org/project/views_bulk_operations)**
    (`views_bulk_operations`) — the actions engine behind the buttons.
  - Core **Node** (`node`), **Views** (`views`), **Block** (`block`), and **Action**
    (`action`).

## Install with Composer

From the project root:

```bash
composer require drupal/admin_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update Views
Bulk Operations and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_actions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_actions -y
```

Enabling installs the `admin_actions` view and attempts to place its button block.
Next, choose which actions the buttons run and position the block — see
[Configuration](../configuration/index.md).

## Optional submodule — Refresh date

Admin actions ships one example submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Refresh date** | `refresh_date` | A sample custom action (`node_refresh_date_action`) that resets a node's *authored on* (created) timestamp to now. It defers to the node's update access, so only users who can edit the node can run it. Enable it as a working example, or as a handy action in its own right. |

```bash
drush en refresh_date -y
```
