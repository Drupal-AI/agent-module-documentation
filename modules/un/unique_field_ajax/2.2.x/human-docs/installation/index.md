# Installation

## Requirements

Unique Field Ajax needs only **Drupal 8, 9, 10, or 11**
(`core_version_requirement: ^8 || ^9 || ^10 || ^11`). It has no Composer
dependencies, no PHP extension requirements, and no submodules — it works with
core's Field and Node systems out of the box.

## Install with Composer

From the project root:

```bash
composer require drupal/unique_field_ajax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/unique_field_ajax -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en unique_field_ajax -y
```

Enabling the module changes nothing on its own. It simply adds the "Unique field
settings" and "Unique title settings" sections to the relevant admin forms — see
[Configuration](../configuration/index.md) to switch uniqueness on for a specific
field or content type.
