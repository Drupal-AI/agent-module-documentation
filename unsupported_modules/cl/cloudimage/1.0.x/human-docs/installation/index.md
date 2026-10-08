# Installation

## Requirements

Cloudimage by Scaleflex is lightweight:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- A **Cloudimage account** with a token (or a configured CNAME) — create one at
  [scaleflex.com](https://www.scaleflex.com/). This is not a Drupal dependency, but
  the module does nothing without it.

There are no other Drupal module dependencies and no third‑party PHP library
requirements.

## Install with Composer

Note that the **project (Composer) name differs from the module machine name**. The
machine name is `cloudimage`, but you install it with:

```bash
composer require drupal/cloudimage_by_scaleflex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudimage_by_scaleflex -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudimage -y
```

## Verify it worked

After enabling, go to **Configuration → Cloudimage by Scaleflex**
(`/admin/config/cloudimage-by-scaleflex`). You should see the settings form. Until
you enter your token and turn optimization on there, the module leaves your images
untouched — head to [Configuration](../configuration/index.md) next.
