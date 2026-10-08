# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), part of the standard install.
- The **Token** module (`token`), used to build share URLs and text from token
  values. Composer pulls it in automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/sticky_social_bar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Token module
and any other shared dependencies alongside Sticky Social Bar.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sticky_social_bar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sticky_social_bar -y
```

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the **Sticky Social Bar** block and place it in a region — the *footer*
   is the usual choice so the bar sits along the bottom of the page.
3. Optionally set block visibility so the bar only shows on the content you want.

## Verify it worked

After enabling, visit the settings form at
`/admin/config/media/sticky-social-bar`, turn on at least one social channel, save,
then load a page where the block is placed. The sticky bar should appear along the
bottom and stay visible as you scroll. See
[Configuration](../configuration/index.md) to choose which channels appear.
