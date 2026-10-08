# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Metatag** module (`metatag`) — this is the only dependency, and it is
  required. OG Default Image plugs into Metatag and has no purpose without it.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/og_default_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Metatag isn't already present, Composer will pull it in.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/og_default_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en og_default_image -y
```

This enables Metatag as well if it isn't already on.

## Verify it worked

Go to **Configuration → Search and metadata → Metatag** and confirm a **Default OG
Image** tab is present. Upload an image there, then add the
`[og_default_image:og_default_image]` token to your Open Graph image meta tag as
described in the [guide overview](../index.md). To confirm the tag renders, view
the page source of a node without its own image and look for an `og:image` meta tag
pointing at your uploaded file.
