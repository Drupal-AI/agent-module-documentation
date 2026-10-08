# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal will enable it automatically when you turn on Layout
  Builder Extras.

There are no third‑party Composer or PHP library requirements.

**Optional:** [Section Library](https://www.drupal.org/project/section_library)
(`drupal/section_library`). When it is installed and enabled, its "From library"
picker is folded into the combined section‑actions dialog. Everything else works
without it.

## Install with Composer

From the project root:

```bash
composer require drupal/layoutbuilder_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layoutbuilder_extras -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layoutbuilder_extras -y
```

Enabling the module changes nothing on its own — every feature is off by default.
Head to [Configuration](../configuration/index.md) to switch on the tweaks you
want.
