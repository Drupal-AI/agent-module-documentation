# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules —
  pulled in automatically as dependencies.
- The contributed **Iframe** module (`iframe`), which this module builds on for
  its iframe field handling.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/iframe_video -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Iframe module dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/iframe_video -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iframe_video -y
```

Drupal enables the required Media, Media Library, and Iframe modules
automatically as dependencies.

## Verify it worked

Go to **Structure → Media types → Add media type** and confirm the **iframe
video** media source is available to choose. Create a media type with it, add a
video of that type, and check it appears in the Media Library for reuse.
