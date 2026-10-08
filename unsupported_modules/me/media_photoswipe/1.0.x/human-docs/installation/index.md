# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) enabled — the module's declared dependency.
- The **`levmyshkin/photo-swipe`** JavaScript library, installed via Composer (see
  below).

There are no PHP library requirements.

> **Note:** this module is marked unsupported/obsolete by its maintainers, who
> recommend the [PhotoSwipe](https://www.drupal.org/project/photoswipe) module
> instead. Consider that before installing on a new site.

## Install with Composer

From the project root:

```bash
composer require drupal/media_photoswipe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. You also need the PhotoSwipe JavaScript library, which is
installed as a Composer package:

```bash
composer require levmyshkin/photo-swipe
```

(For this to place the library correctly, your project should be configured to
install asset packages into `libraries/` — for example via `composer/installers`
and an `installer-paths` entry for `type:drupal-library`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_photoswipe -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_photoswipe -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → Media → Media PhotoSwipe**
(`/admin/config/media/media-photoswipe`) — if the settings form loads, the module
is enabled. Then set the **Media PhotoSwipe** formatter on an image field's
**Manage display**, view a page with images, and confirm that clicking a thumbnail
opens the PhotoSwipe lightbox. If the lightbox doesn't appear, re‑check that the
`levmyshkin/photo-swipe` library is present under `libraries/`.
