# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An **Alive5 account** with a widget ID (you enter it during
  [Configuration](../configuration/index.md)).
- No additional Composer or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/alive5 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alive5 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alive5 -y
```

Once enabled, continue to [Configuration](../configuration/index.md) to enter your
widget ID and choose where the chat widget appears. Uninstalling the module
removes the widget cleanly.
