# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 ||
  ^11`).

There are no other module dependencies and no third-party libraries — the
formatters extend core's own field formatters.

## Install with Composer

From the project root:

```bash
composer require drupal/element_class_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/element_class_formatter -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en element_class_formatter -y
```

Once enabled, the module's formatters appear in the **Format** dropdown for
matching field types on any bundle's *Manage display* page. There is nothing to
configure globally — see the module [overview](../index.md) for how to apply a
formatter to a field.

## Submodule — Responsive Image support

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| Element Class Formatter: Responsive Image | `element_class_formatter_responsive_image` | A `responsive_image_class` formatter that adds the same element-class treatment to Responsive Image fields. |

Enable it if you use Responsive Image fields:

```bash
drush en element_class_formatter_responsive_image -y
```

It requires the base module (already present) and core's Responsive Image module.
