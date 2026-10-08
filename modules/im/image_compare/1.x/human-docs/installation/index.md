# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- The **Image Compare** JavaScript library (installed separately, see below).

## Install with Composer

From the project root:

```bash
composer require drupal/image_compare -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_compare -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Add the JavaScript library

The slider is powered by the third-party **image-compare** JavaScript library, which
is **not** bundled with the module. Consult the module's `README` file for the exact
installation instructions and expected library path — typically the library is placed
under your site's `/libraries` directory (in the Drupal root, not inside `/core`).

## Enable the module

```bash
drush en image_compare -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Accessible Slider for Media** | `image_compare_media` | Works with Media entities of type Image (including media that reference other image media). |
| **Responsive** | `image_compare_responsive` | Adds responsive-image support to the slider. |
| **Media Responsive** | `image_compare_media_responsive` | Combines the Media and Responsive behaviors. |

Enable one with, for example:

```bash
drush en image_compare_media -y
```

Then clear the cache:

```bash
drush cr
```

## Verify it worked

Add a **multi-value image field** to a content type, upload **at least two** images
to a piece of content, and set that field's format to **Image Compare Accessible
Slider** on the entity's *Manage display*. Viewing the content should show a draggable
before/after slider. If nothing appears, re-check that the JavaScript library is
installed at the path the `README` specifies, and clear the cache. See the
["How to use it"](../index.md#how-to-use-it) section for the formatter options.
