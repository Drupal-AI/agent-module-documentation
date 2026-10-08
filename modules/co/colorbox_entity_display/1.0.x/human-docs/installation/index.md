# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- The **Colorbox** module (`colorbox`) and its Colorbox JavaScript library — this is
  a required dependency and provides the lightbox itself.

## Install with Composer

From the project root:

```bash
composer require drupal/colorbox_entity_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
including Colorbox, as needed. Follow the Colorbox module's own instructions to make
sure its JavaScript library is in place.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/colorbox_entity_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colorbox_entity_display -y
```

This also enables Colorbox if it is not already on.

## Verify it worked

Create a link with the `colorbox-display` class pointing at the entity-load endpoint
(see "How to use it" on the [overview page](../index.md)) and click it — the entity
should open inside a Colorbox lightbox rather than loading a new page.
