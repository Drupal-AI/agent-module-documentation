# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Discovery** module (`layout_discovery`) — Drupal enables this
  automatically as a dependency when you turn on Slick Layouts.
- The **Slick** JavaScript library — this is a third-party front-end dependency
  that powers the carousel. Make it available in your site's libraries the same
  way you would for any Slick-based module; without it the slider markup will
  render but will not animate.

## Install with Composer

From the project root:

```bash
composer require drupal/slider_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slider_layouts -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slider_layouts -y
```

## Verify it worked

Open Layout Builder on any layout-enabled entity (for example a content type's
**Manage display** → **Manage layout**). When you choose to add a section, a
new **Slider Section** option should be available. Add it, drop a couple of
blocks in, and each block becomes a slide in the carousel.
