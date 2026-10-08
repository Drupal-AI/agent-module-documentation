# Installation

## Requirements

Juicer is deliberately lightweight:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- A **Juicer.io account** (free or paid) with at least one feed configured — this
  is what supplies the posts.
- No other Drupal modules are required; Juicer depends only on core.

The front‑end libraries it uses (Swiper for slider feeds and Packery for the
masonry layout) are loaded automatically from Juicer's CDN, so there is nothing to
download or place in a `/libraries` folder.

## Install with Composer

From the project root:

```bash
composer require drupal/juicer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/juicer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en juicer -y
```

Or enable **Juicer** on the **Extend** page (`/admin/modules`).

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click *Place
block* in any region. If the module is enabled, **Juicer Social Feed** appears in
the list of available blocks. Place it, enter your feed slug, and save — the feed
should render on the front end immediately. See
[Configuration](../configuration/index.md) for the block's settings.
