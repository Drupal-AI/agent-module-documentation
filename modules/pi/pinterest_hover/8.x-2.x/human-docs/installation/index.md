# Installation

## Requirements

Pinterest Hover Button is lightweight and has no third-party dependencies:

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other contrib modules, Composer packages, or PHP libraries are required.

Note that the button itself depends on Pinterest's `pinit.js` script, which is
loaded from Pinterest's CDN at runtime — so your visitors need to be able to reach
`assets.pinterest.com` for the button to work.

## Install with Composer

From the project root:

```bash
composer require drupal/pinterest_hover -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pinterest_hover -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pinterest_hover -y
```

## Verify it worked

Go to **Configuration → Pinterest Hover**
(`/admin/config/pinterest-hover/config`) and confirm the settings form loads. Turn
on "load Pinterest JS", save, then visit a page with images and hover over one — the
Pinterest "Pin It" button should appear over the image. If it does not, see
[Configuration](../configuration/index.md) to check your content-type targeting and
exclusion selectors.
