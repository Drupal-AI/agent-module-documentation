# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- Drupal core only — there are no additional module dependencies and no third‑party
  Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_pointer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_pointer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_pointer -y
```

## Verify it worked

After enabling, an **Image Pointer** entry should appear in the admin configuration
menu at **Administration → Configuration → Image Pointer**. Opening it should show
the module's settings form. See [Configuration](../configuration/index.md) for how
to set things up.
