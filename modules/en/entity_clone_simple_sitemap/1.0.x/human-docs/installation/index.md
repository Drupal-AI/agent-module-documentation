# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **[Entity Clone](https://www.drupal.org/project/entity_clone)** (`entity_clone`) —
  required to perform the actual cloning.
- **[Simple Sitemap](https://www.drupal.org/project/simple_sitemap)**
  (`simple_sitemap`, **v4.2.2 or later**) — provides the sitemap overrides and
  configuration this module copies.

Both are enabled automatically as dependencies when you install this module.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_clone_simple_sitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity Clone and
Simple Sitemap and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_clone_simple_sitemap -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_clone_simple_sitemap -y
```

Drush will enable Entity Clone and Simple Sitemap at the same time if they are not
already on. There is no configuration step — the module works automatically.

## Verify it worked

Give an entity (say a node) some Simple Sitemap overrides, then clone it with Entity
Clone. Open the clone's Simple Sitemap settings and confirm the inclusion/exclusion
overrides match the original.
