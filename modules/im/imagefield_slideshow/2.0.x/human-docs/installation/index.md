# Installation

## Requirements

- **Drupal 8.9 through 10, or 11**
  (`core_version_requirement: >=8.9 <11.0.0-stable || ^11`).
- Core's **Image** module (`image`) — enabled by default in a standard install,
  and pulled in as a dependency.

There are no third-party Composer or PHP library requirements — the jQuery Cycle2
library that powers the slideshow is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/imagefield_slideshow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imagefield_slideshow -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagefield_slideshow -y
```

There are no submodules. Once enabled, the **Imagefield Slideshow** formatter is
available on any image field — see the
[main guide](../index.md#how-to-use-it) for how to apply it.

## Verify it worked

Open a multi-value image field's *Manage display* screen and confirm **Imagefield
Slideshow** appears as a choice in the **Format** column. Apply it, then view a
piece of content with several images in that field — the images should rotate as a
slideshow.
