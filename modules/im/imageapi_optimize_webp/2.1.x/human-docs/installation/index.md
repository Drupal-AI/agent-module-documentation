# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **ImageAPI Optimize** (Image Optimize) module (`drupal/imageapi_optimize`)
  — a hard dependency that provides the pipeline framework this module plugs
  into. Composer pulls it in automatically.
- **GD with WebP support** on your server — the WebP Deriver uses PHP's
  `imagewebp()` function, so your PHP's GD extension must be built with WebP
  support. (Most modern hosting has this; DDEV's PHP includes it.)

There are no third-party Composer library requirements beyond the module
dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/imageapi_optimize_webp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Image Optimize
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imageapi_optimize_webp -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it (Drush will enable the Image Optimize dependency automatically):

```bash
drush en imageapi_optimize_webp -y
```

There is no configuration form to visit on install — the **WebP Deriver**
processor simply becomes available to add to Image Optimize pipelines. See
[Configuration](../configuration/index.md) for setup.

## Optional submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **ImageAPI Optimize WebP Responsive** | `imageapi_optimize_webp_responsive` | Automatically injects `<source type="image/webp">` into core **responsive image** output, so responsive image fields serve WebP without you editing any markup. Enable it if you use responsive image styles. |

Enable it when you need it:

```bash
drush en imageapi_optimize_webp_responsive -y
```
