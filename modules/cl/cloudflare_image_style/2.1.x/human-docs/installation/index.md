# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`), enabled automatically as a dependency.
- No third‑party PHP libraries and no API keys in Drupal — the resizing itself is
  a feature of your Cloudflare account/zone. To benefit from CDN delivery in
  production, your live site must sit behind Cloudflare with image resizing
  available (an enterprise Cloudflare Images feature).

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare_image_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_image_style -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_image_style -y
```

## Verify it worked

Go to **Configuration → Media → Image styles**, edit any style, and confirm you
see the new **Serve from Cloudflare** and **Cloudflare Effect** fields on the
form. Configuring them is covered in [Configuration](../configuration/index.md).
Nothing changes for your images until you enable those fields on a style.
