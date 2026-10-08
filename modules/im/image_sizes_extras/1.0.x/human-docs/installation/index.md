# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The [Image Sizes](https://www.drupal.org/project/image_sizes) module
  (`image_sizes`) — this add‑on depends on it and reuses its presets. Composer
  installs it for you when you require this module.

The module attaches its own JavaScript library (`image_sizes_extras/core`)
automatically; there is nothing to install by hand for that.

## Install with Composer

From the project root:

```bash
composer require drupal/image_sizes_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Image Sizes and
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_sizes_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_sizes_extras -y
```

Drupal will enable Image Sizes at the same time if it isn't already on.

## Verify it worked

Open an image field's **Manage display** (**Structure → Content types →
*(bundle)* → Manage display**) and confirm the **Image Sizes Extras** formatter
appears in the format list. Apply it with one of your Image Sizes presets and
view the rendered page — the `<img>` should carry a `srcset` attribute. See the
[manual setup guide](../index.md) for the full workflow.
