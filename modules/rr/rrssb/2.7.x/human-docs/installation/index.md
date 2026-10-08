# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`rrssb/rrssb-plus`** asset library (`^0.5.0`), which supplies the icons,
  CSS, and JavaScript. This is a Composer dependency and is pulled in
  automatically when you require the module — see below.
- No other Drupal modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/rrssb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it also brings in the bundled `rrssb/rrssb-plus`
library that the buttons rely on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rrssb -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rrssb -y
```

Enabling the module creates a **Default** button set to get you started. See the
[overview](../index.md) for how to build button sets and place them as a block, a
Views field, or per content type.
