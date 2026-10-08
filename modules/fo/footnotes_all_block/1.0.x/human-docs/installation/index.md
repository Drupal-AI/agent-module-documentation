# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Footnotes** module (`footnotes`), version **4.0 or newer** — this is a
  hard dependency and is where the footnotes themselves come from.

> **Note:** This project is marked *obsolete* and *minimally maintained*
> upstream. The maintainers point to issue
> [#3098138](https://www.drupal.org/node/3098138) for ways to achieve the same
> result without JavaScript. Keep that in mind before adopting it on a new site.

## Install with Composer

From the project root:

```bash
composer require drupal/footnotes_all_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Footnotes module if it isn't already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/footnotes_all_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en footnotes_all_block -y
```

Drupal will enable the Footnotes module too if it isn't already on.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in a region — the **Footnotes** block from this module should be
available to place. Place it, add some content that uses footnotes, and confirm
the footnotes gather into the block on the rendered page.
