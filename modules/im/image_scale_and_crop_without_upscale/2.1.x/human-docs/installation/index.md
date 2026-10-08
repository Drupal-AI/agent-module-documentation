# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — the only dependency, enabled automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_scale_and_crop_without_upscale -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_scale_and_crop_without_upscale -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_scale_and_crop_without_upscale -y
```

## Verify it worked

Go to **Configuration → Media → Image styles**, edit or create a style, and open the
**Add effect** dropdown. You should see a **Scale and crop (without upscaling)**
effect available to add. See the main guide's "How to use it" for configuring it.

If you add this effect to a style that already produced derivatives, flush that
style's derivatives so existing images are regenerated with the new behaviour.
