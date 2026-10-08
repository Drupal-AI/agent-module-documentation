# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Media Contextual Cropping API** (`media_contextual_crop`, `~2.0`).
- **Media Library Media Modify** (`media_library_media_modify`,
  `^1.0.0 || ^2.0.0@beta`) — note this accepts a **beta** release.
- Core's **Field** and **Media** modules.
- **At least one crop adapter** — Focal Point (`media_contextual_crop_fp_adapter`)
  or Image Widget Crop (`media_contextual_crop_iwc_adapter`).
- **`cweagans/composer-patches`** (`^1.7`) and `composer/installers` — installing
  this module applies patches.

## Allow the patches plugin first

Because installation applies patches via `cweagans/composer-patches`, that plugin
**must be allowed** in your project's `composer.json`, or `composer require` will
stop with a plugin error. Confirm your root `composer.json` contains:

```json
{
    "config": {
        "allow-plugins": {
            "cweagans/composer-patches": true
        }
    }
}
```

## Install with Composer

From the project root:

```bash
composer require drupal/media_contextual_crop_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the base API
module, Media Library Media Modify, and other shared dependencies as needed. Add a
crop adapter as well, for example:

```bash
composer require drupal/media_contextual_crop_iwc_adapter -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_contextual_crop_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_contextual_crop media_library_media_modify media_contextual_crop_field_formatter media_contextual_crop_iwc_adapter -y
```

(Swap in `media_contextual_crop_fp_adapter` if you prefer Focal Point.)

## Verify it worked

Go to a bundle's **Manage display** (**Structure → … → Manage display**), find a
media entity reference field, and confirm the contextual crop formatter appears in
its format dropdown. Selecting it and editing content should let you crop per
reference.
