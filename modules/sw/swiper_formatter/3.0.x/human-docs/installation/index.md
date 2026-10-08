# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- The **Token** module (`drupal/token`) — a dependency, used for slide captions
  and links.
- The **Swiper** JavaScript library. By default a template can use the `remote`
  CDN source (unpkg) or the self-hosted `package` build bundled with the module.
  If you prefer the `local` / `local_minified` source, place the Swiper library at
  `/libraries/swiper/`.

## Install with Composer

From the project root:

```bash
composer require drupal/swiper_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — this will bring in Token if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/swiper_formatter -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en swiper_formatter -y
```

Enabling the module installs a `default` Swiper template (plus a few breakpoint
demo templates). Leave the `default` template in place — new templates are seeded
from it.

## Submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Swiper formatter CKEditor** | `swiper_formatter_ckeditor` | A placeholder for a future CKEditor 5 button. It currently ships no functional code, so there's usually no reason to enable it yet. |

## Grant the permission

The module defines one permission, **Administer Swiper formatter**
(`administer swiper_formatter`), which controls managing Swiper templates. Grant
it at **People → Permissions** to any role that should create or edit templates.

## Next step

With the module enabled, create a Swiper template and apply a formatter or the
Views style. See the module [overview](../index.md#how-to-use-it) for the full
walkthrough.
