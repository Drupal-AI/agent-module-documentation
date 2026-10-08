# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_visibility -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_visibility -y
```

## Verify it worked

Go to **Structure → Content types**, pick a content type, open **Manage fields**, and
confirm you can add the **Node Visibility** field. Add it, configure a condition on a
node of that type, and check the node is shown or hidden as expected. See the
[overview](../index.md) for the full walkthrough.
