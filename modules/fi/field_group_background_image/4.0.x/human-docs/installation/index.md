# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Field Group** (`drupal/field_group`, version `^3.4 || ^4.0`) — required. This
  is a contrib module, so Composer pulls it in for you.
- Core's **Field** module (`field`), which Drupal enables automatically.
- **Optional:** the contrib **Color Field** (`color_field`) module, only if you
  want the background‑color feature.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_background_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in the required **Field Group** module
if you don't already have it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group_background_image -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_background_image -y
```

This enables Field Group as a dependency if it isn't already on. There is no
settings form to visit — the **Background Image** format now appears inside Field
Group on any entity's **Manage display** tab. See the
[overview](../index.md#how-to-use-it) for how to configure it.

To use the optional background‑color feature, also enable Color Field:

```bash
composer require drupal/color_field -W
drush en color_field -y
```

There are no submodules.
