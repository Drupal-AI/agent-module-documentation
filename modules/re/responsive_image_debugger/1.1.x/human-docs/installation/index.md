# Installation

> **Development and testing only.** This module deletes your public
> `styles` folder on install and overrides core's `image_style` entity class.
> Never enable it on a production site, and never enable it alongside
> **ImageAPI Optimize** or any other module that overrides the `image_style`
> class.

## Requirements

Responsive Image Debugger needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Image Effects** module (`image_effects`) and its dependencies — this is
  required, because the module uses Image Effects' "Text Overlay" effect to stamp
  the style name onto images.
- A working image toolkit — GD2, ImageMagick, or GraphicsMagick all work.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_image_debugger -W
```

The `-W` (`--with-all-dependencies`) flag pulls in **Image Effects** and any
other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_image_debugger -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_image_debugger -y
```

On enable, the module removes the public `styles` folder (image derivatives are
regenerated on demand) and registers the Text Overlay effect automatically. No
further configuration is required.

## Verify it worked

Visit a page that displays responsive images. Each image should now carry an
overlay showing its image‑style name and dimensions. Resize the browser and the
labels should update as different variants are selected.

## When you're finished

Uninstall the module to restore core's image‑style handling:

```bash
drush pmu responsive_image_debugger -y
```
