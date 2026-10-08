# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Swiper** JavaScript library, which the slideshow uses. (The module moved to
  Swiper to remain compatible with jQuery 4, shipped in Drupal 11.) Follow the
  project's README for how it expects Swiper to be made available.
- No module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_gallery_slideshow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_gallery_slideshow -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_gallery_slideshow -y
```

## Verify it worked

There's no admin settings page. To confirm the formatter is available, go to an
entity's **Manage display**, find an entity reference field, and check that the
Entities Gallery To Slideshow formatter appears in its **Format** dropdown. Then
follow the "How to use it" steps in the parent [guide](../index.md) — and remember
to add your own CSS, since the module ships only minimal styles.
