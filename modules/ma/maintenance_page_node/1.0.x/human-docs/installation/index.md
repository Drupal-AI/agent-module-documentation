# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contributed modules — it uses Drupal core's Node system and
  maintenance mode.

## Install with Composer

From the project root:

```bash
composer require drupal/maintenance_page_node -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maintenance_page_node -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maintenance_page_node -y
```

## Verify it worked

Go to **Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`). You should see a new **Maintenance
Node** autocomplete field on the form. See [Configuration](../configuration/index.md)
to create a node and select it, then turn on maintenance mode and view the site
anonymously to confirm your node is shown.
