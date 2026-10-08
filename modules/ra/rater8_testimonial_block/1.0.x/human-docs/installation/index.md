# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other Drupal modules are required — the block builds on core's Block system.
- A **Rater8 account** with an ID for the testimonials you want to display.

## Install with Composer

From the project root:

```bash
composer require drupal/rater8_testimonial_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rater8_testimonial_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rater8_testimonial_block -y
```

After enabling, clear the cache so the new block plugin is registered:

```bash
drush cr
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block**. The Rater8 Testimonials block should appear in the list. If it's there,
the module is ready — continue to [Configuration](../configuration/index.md) to
place it and set your Rater8 ID.
