# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).

There are no module dependencies. Because the ElevateZoom Plus library is loaded
from a **CDN**, there is **no library file to download** — this is the main
practical difference from the separate `elevate_image_zoom` project.

## Install with Composer

From the project root:

```bash
composer require drupal/elevatezoom -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elevatezoom -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elevatezoom -y
```

## Verify it worked

Apply the ElevateZoom formatter to an image field on a content type's **Manage
display** page (see the [main guide](../index.md)), then view a piece of content
that uses that field. Hovering over the image should show a magnified view. If
nothing happens, clear the cache with `drush cr` and confirm the page can reach
the CDN.
