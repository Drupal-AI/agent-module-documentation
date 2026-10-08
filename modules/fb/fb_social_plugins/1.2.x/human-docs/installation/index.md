# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Block** module (`block`) — the module's only dependency, enabled
  automatically as needed.
- No third‑party PHP libraries. The Facebook JavaScript SDK is loaded from Facebook
  at runtime, only on pages where a plugin renders.

## Install with Composer

From the project root:

```bash
composer require drupal/fb_social_plugins -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fb_social_plugins -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fb_social_plugins -y
```

After configuring the plugins, flush all caches (`drush cr`) as the module's
documentation recommends.

## Verify it worked

Go to `/admin/fb-social-plugins`. You should see the configuration links for the
Like, Share, Page, and Comments plugins. Configure at least one (see
[Configuration](../configuration/index.md)), place its block or enable its field,
then view a front‑end page to confirm the Facebook plugin renders.
