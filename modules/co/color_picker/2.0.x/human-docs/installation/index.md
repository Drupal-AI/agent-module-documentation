# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies, no third-party libraries, and no submodules — the element
  uses core's jQuery, Drupal, and once libraries plus the module's own small JS/CSS.

## Install with Composer

From the project root:

```bash
composer require drupal/color_picker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/color_picker -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en color_picker -y
```

That's all — there's no configuration and no permissions to set. Once enabled, the
`color_picker` form element is available to any form. See the [overview](../index.md)
for a usage example.
