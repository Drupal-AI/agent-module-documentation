# Installation

## Requirements

Responsive Slideshow needs:

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Image** module (`image`), enabled automatically as a dependency.
- A **Bootstrap 5** theme or subtheme. This module drives Bootstrap's built‑in
  carousel, so it only makes sense on a Bootstrap‑based theme — on any other
  theme the slideshow will not have the framework's markup, styling, or
  JavaScript to work with.

There are no third‑party Composer or PHP library requirements beyond core.
(The `jQuery Update` requirement mentioned in older notes applies only to the
Drupal 7 version, not this one.)

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_slideshow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_slideshow -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_slideshow -y
```

On enable, the module creates a **Responsive Slideshow** content type and a
**Responsive Slideshow** block.

## Verify it worked

- Go to **Structure → Content types** and confirm a **Responsive Slideshow**
  content type is present.
- Go to **Structure → Block layout** and confirm a **Responsive Slideshow** block
  is available to place.

Continue to [Configuration](../configuration/index.md) to add content, adjust the
carousel options, and place the block in a region.
