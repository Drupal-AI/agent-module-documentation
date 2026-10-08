# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`) —
  a deliberately wide range.
- Core's **Image** module (`image`) — the image styles this module flushes.
- Core's **Action** module (`action`) — this is what lets the flush appear as a **bulk
  operation** on the media listing. Both are enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flush_single_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flush_single_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flush_single_image -y
```

Drupal will enable the core `image` and `action` modules as dependencies if they are
not already on.

## Verify it worked

Go to **`/admin/config/media/image-styles/flush-single`** — you should see the flush
form with a field for a source image path. You can also confirm the Drush command is
registered:

```bash
drush flush_single_image --help
```

If you plan to let editors flush images from the media listing, check that the
**Action** module is enabled — that dependency is what makes the bulk action appear.
