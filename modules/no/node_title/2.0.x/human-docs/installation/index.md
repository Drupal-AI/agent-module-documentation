# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's node system (present on any standard Drupal site).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_title -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_title -y
```

There is no configuration — the extra title field appears on node forms immediately.

## Verify it worked

Edit any node. In the advanced sidebar of the edit form you should now see a
collapsible **Node Title** group holding the supplementary title field. Enter a value,
save, and confirm it persists.
