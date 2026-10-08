# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Custom Menu Links** module (`menu_link_content`) — Drupal enables it as
  a dependency. Visibility applies only to custom (`menu_link_content`) links, not
  to module-defined menu links.

No contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link_content_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_link_content_visibility -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link_content_visibility -y
```

Drupal enables `menu_link_content` as a dependency. There is no configuration
form — head to [Configuration](../configuration/index.md) to add visibility
conditions to your menu links.
