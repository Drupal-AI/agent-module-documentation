# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI module** (`drupal/ai`) — the framework this provider plugs into.
  Composer pulls it in automatically.
- The **Key module** (`drupal/key`) to hold the mittwald credential outside
  exported configuration. If it is not already present, add it with
  `composer require drupal/key` and enable it.

You will also need mittwald AI **credentials** from your mittwald account.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_mittwald -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_mittwald -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_mittwald -y
```

This module ships no submodules. Next, add your credential and register the
provider in [Configuration](../configuration/index.md).
