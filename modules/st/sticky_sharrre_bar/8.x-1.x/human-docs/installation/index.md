# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.
- Two front-end JavaScript libraries, downloaded into your site's `libraries`
  directory:
  - **jQuery Waypoints** version 4.0.0 or higher — from
    <http://imakewebthings.com/jquery-waypoints>.
  - **jQuery Sharrre** version **1.3.5 only** — from
    <https://github.com/Julienh/Sharrre/archive/1.3.5.zip>. Note: Sharrre 2.0.0
    and higher does **not** work with this module.

> **Security note:** the Sharrre library ships a `sharrre.php` file. Delete it
> after unpacking the library — this module provides its own `/sharrre` controller
> and does not need that PHP file, which is a known risk to leave in place.

## Install with Composer

From the project root:

```bash
composer require drupal/sticky_sharrre_bar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sticky_sharrre_bar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sticky_sharrre_bar -y
```

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the **Sticky Sharrre Bar** block and place it in a region. It defaults to
   the *header* region; if your theme has no header region, choose another region
   manually.
3. In the block configuration, choose the social providers to show. You can also
   uncheck **Use the CSS of module** if you prefer to style the bar in your own
   theme.

## Verify it worked

Visit a page on your site as a normal visitor. The share bar should appear and
stick to the page as you scroll. If the buttons do not render, re-check that both
JavaScript libraries are in the `libraries` directory with the exact versions
listed above.
