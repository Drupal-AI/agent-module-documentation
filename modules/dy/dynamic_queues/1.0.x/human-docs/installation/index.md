# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other module dependencies.
- No external Composer or JavaScript library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_queues -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_queues -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_queues -y
```

## Verify it worked

Go to `/admin/dynamic-queues/config` and confirm you can see the **Maximum queue
limit** setting. Because Dynamic Queues is driven from code, the real test is to
enqueue a few items (see [Configuration](../configuration/index.md)) and then run:

```bash
drush queue:list
```

You should see one or more `dynamic_queues:…` sub‑queues listed with their item
counts.
