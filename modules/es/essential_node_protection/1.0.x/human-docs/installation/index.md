# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Node** module (`node`) — the only dependency, and always present on a
  content site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/essential_node_protection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/essential_node_protection -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en essential_node_protection -y
```

As soon as it is enabled, all three slots (front page, 403 and 404) are protected
by default. Head to [Configuration](../configuration/index.md) only if you want to
change that.

## Verify it worked

Make sure a node is set as your front page (or 403/404), then edit that node as an
administrator. The **Delete** button/tab should be gone, and visiting its delete
URL directly should be forbidden. A non‑essential node should still show its Delete
button as normal.
