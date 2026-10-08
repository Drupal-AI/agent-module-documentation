# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **System**, **Views**, **Image**, and **Media** modules. These are core
  modules and Drupal enables them as dependencies when you turn on Image Alt
  Fallback. (Views and Media power the bundled "Media Alts" browsing view.)

There are no third-party Composer or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_alt_fallback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_alt_fallback -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_alt_fallback -y
```

Then clear the cache:

```bash
drush cr
```

## Verify it worked

After enabling, go to **Configuration → Media → Image Alt Fallback**
(`/admin/config/media/image-alt-fallback`) and confirm the settings form loads with
your entity types and their image fields listed. Nothing is applied until you
configure at least one field there — see [Configuration](../configuration/index.md).
You can also check the new **Content → Media Alts** tab
(`/admin/content/media-alts`) to review which media items currently lack alt text.
