# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Image** module (`image`) enabled — Drupal turns it on automatically
  as a dependency if it isn't already. (It usually is on a standard install.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/decorative_image_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/decorative_image_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decorative_image_widget -y
```

There is no configuration form to visit. Once enabled, the **Decorative**
checkbox option becomes available in the widget settings of any eligible image
field. See the [overview](../index.md) for how to switch it on for a field.
