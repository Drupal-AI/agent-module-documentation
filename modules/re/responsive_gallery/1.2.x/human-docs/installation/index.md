# Installation

## Requirements

Responsive Gallery needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of the standard install and is
  enabled automatically as a dependency.

There are no third‑party Composer packages or external JavaScript libraries to
download — the lightbox component is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_gallery -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_gallery -y
```

## Verify it worked

Edit the **Manage display** of a bundle that has a multi‑value image field. The
field's **Format** dropdown should now list **Responsive Gallery**. Select it,
configure the per‑row counts and image style, save, then view a piece of content
with several images — you should see a responsive thumbnail grid that opens a
lightbox on click.
