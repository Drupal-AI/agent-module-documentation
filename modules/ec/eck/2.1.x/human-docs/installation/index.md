# Installation

## Requirements

Entity Construction Kit is core-only — it has no contrib dependencies and no
third-party libraries.

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- No other modules are required. You will typically also use core's **Field UI**
  (to add fields to bundles) and, if you want translations, core **Content
  Translation** — but ECK itself lists no module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/eck -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/eck -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eck -y
```

Once enabled, head to **Structure → Entity Construction Kit**
(`/admin/structure/eck`) to create your first entity type — see
[Configuration](../configuration/index.md).

## Submodules

ECK ships no submodules — the base module is everything you need.
