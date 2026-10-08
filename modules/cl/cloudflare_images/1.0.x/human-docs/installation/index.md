# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other Drupal modules are required. Image files are expected to come through
  media entities of the `image` bundle that reference a file
  (`field_media_image`).
- A **Cloudflare Images subscription**, with your account ID, account hash and an
  API token to hand.

This module is not covered by Drupal's security advisory policy, so review it
before production use — particularly the token‑storage note below.

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare_images -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_images -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_images -y
```

## Verify it worked

Go to **Configuration → Cloudflare Images → Settings**
(`/admin/config/cloudflare_images/settings`) and confirm the settings form loads.
No images are offloaded until you fill it in and the request host matches your
configured site host — see [Configuration](../configuration/index.md).
