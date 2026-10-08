# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Views** module (`views`), which Drupal enables automatically as a
  dependency when you turn on this module.
- Outbound network access to `https://www.drupal.org/planet` so the block can
  fetch the feed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drupal_planet_feeds_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupal_planet_feeds_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupal_planet_feeds_block -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`), click **Place
block** on any region, and confirm the Drupal Planet block appears in the list
(filter by "Planet Drupal"). Once placed and saved, visit that page to see the
latest community posts. See [How to use it](../index.md#how-to-use-it) for the
placement steps in full.
