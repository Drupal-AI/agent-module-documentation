# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other Drupal modules, and no third-party PHP or Composer libraries — it relies
  only on core.
- By default the notice is rendered by a script fetched from `browser-update.org`. If
  outbound calls to that host are a concern, plan to point the script `source` at a
  self-hosted copy (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/bu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bu -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bu -y
```

The module works out of the box with its default settings (which keep the notice off
admin pages). To tune which browsers trigger it, where it shows, and how it reads, see
[Configuration](../configuration/index.md).
