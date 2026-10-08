# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`), which Drupal enables as a dependency.
- The **GD** PHP extension available (the effect decodes source pixels through GD
  even when your site's image toolkit is ImageMagick).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_focus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_focus -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_focus -y
```

There are no submodules. Once enabled, add the **Focus Scale and Crop** effect to
an image style to start using it — see
[How to use it](../index.md#how-to-use-it) on the main page.
