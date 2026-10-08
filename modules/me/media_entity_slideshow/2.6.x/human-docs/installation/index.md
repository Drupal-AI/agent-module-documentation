# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module (`media`) enabled — Drupal turns it on automatically
  as a dependency if it isn't already. (The **Media Library** module is also
  handy for picking slides, though not strictly required.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_slideshow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_slideshow -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_slideshow -y
```

There is no configuration form to visit. Once enabled, **Slideshow** becomes an
available media source when you add a media type. See the [overview](../index.md)
for how to build a slideshow media type.
