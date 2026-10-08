# Installation

## Requirements

Easy Responsive Images needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** (`image`) module, which is part of a standard install and is
  enabled automatically as a dependency.

There are no required third-party libraries. A few **optional** modules unlock
extra behaviour when present, and you only need them if you want the feature:

- **Focal Point** (`focal_point`) — crops aspect-ratio styles around a focal point
  instead of the centre.
- **ImageAPI Optimize WebP** or **WebP** — serves WebP derivatives automatically.
- **AVIF** (`avif`) — serves AVIF derivatives automatically.
- **Imagecache External** (`imagecache_external`) — lets the styles work on remote
  images.

## Install with Composer

From the project root:

```bash
composer require drupal/easy_responsive_images -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easy_responsive_images -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easy_responsive_images -y
```

## Next steps

Enabling the module adds the generator form but does not create any image styles
yet. Head to [Configuration](../configuration/index.md) to generate your responsive
image styles and start using them.
