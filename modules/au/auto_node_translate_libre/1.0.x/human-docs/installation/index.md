# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Auto Node Translate** module (`auto_node_translate`) — this is a provider
  plugin for it and does nothing on its own.
- Access to a **LibreTranslate** server. You can run LibreTranslate yourself
  (it is open source and self-hostable) or use a hosted instance. Some endpoints
  require an API key.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_node_translate_libre -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Auto Node Translate.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_node_translate_libre -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_node_translate_libre -y
```

This also enables `auto_node_translate` if it is not already on.

## After enabling

Point the module at your LibreTranslate endpoint (and API key, if required) as
described in [Configuration](../configuration/index.md), then select
LibreTranslate as the active provider in Auto Node Translate's settings.
