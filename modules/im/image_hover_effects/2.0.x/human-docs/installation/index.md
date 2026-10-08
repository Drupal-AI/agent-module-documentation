# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Image** module (`image`).
- Core's **Responsive Image** module (`responsive_image`) — this dependency is what
  lets the effects apply to responsive image fields.

Drupal enables both core dependencies automatically when you turn on Image Hover
Effects. There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_hover_effects -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_hover_effects -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_hover_effects -y
```

This also enables the Responsive Image and Image modules if they aren't already on.

## Verify it worked

Go to a content type's **Manage display**, set an image field to link to its content
or file, and open the formatter settings. You should see a **hover effect** option
(zoom, fade, slide, etc.). Choose one, save, and hover a linked image on the front
end to confirm the effect runs.
