# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10
  || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency. Drupal will enable it automatically as a dependency when you turn on
  Layout Builder Styles. (Layout Builder in turn relies on core's Layout Discovery
  module.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_styles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_styles -y
```

Make sure Layout Builder itself is enabled and turned on for at least one entity
display, otherwise there is nowhere for the style selectors to appear. There are
no submodules.

Once enabled, head to [Configuration](../configuration/index.md) to define your
first styles — the module does nothing visible until you have created some.
