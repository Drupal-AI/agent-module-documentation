# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 8.0 or newer** (`php: >=8.0`).
- Core's **Image** module (`image`) — a dependency Drupal enables automatically.
- The **`enshrined/svg-sanitize`** PHP library (`~0.22`) — this does the SVG
  sanitization that strips scripts and other unsafe markup. Composer installs it
  for you.

## Install with Composer

From the project root:

```bash
composer require drupal/svg_image_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`enshrined/svg-sanitize` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/svg_image_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_image_field -y
```

Drupal enables core's **Image** module automatically as a dependency. From here,
add a **Vector image** field through the Field UI — see the
[overview](../index.md#how-to-use-it).

## Submodule — a ready-made media type

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **SVG Image Field Media Bundle** | `svg_image_field_media_bundle` | Imports a preconfigured *Vector image* media type (and Acquia Site Studio components when present) so you don't have to build the SVG media type by hand. |

Enable it only if you want the ready‑made media type:

```bash
drush en svg_image_field_media_bundle -y
```

It requires the base SVG image field module, which is already present once you've
installed it above.
