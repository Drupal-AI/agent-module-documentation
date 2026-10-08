# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Simple XML Sitemap** module (`simple_sitemap`, version 4.x recommended)
  installed and configured first — this module extends it and cannot work without
  it.
- No external libraries or APIs are required.

Two related modules are recommended but not required: **Pathauto** (helpful if you
link to Drupal-generated paths) and **Redirect** (useful for managing redirects
alongside your custom sitemap URLs).

## Install with Composer

If you don't already have Simple XML Sitemap, install it first:

```bash
composer require drupal/simple_sitemap -W
```

Then install this module:

```bash
composer require drupal/simple_sitemap_arbitrary_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name,
`drupal/simple_sitemap_arbitrary_links`, matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_sitemap_arbitrary_links -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_sitemap_arbitrary_links -y
```

## Grant the permission

The links form is gated by one permission. Under **People → Permissions**
(`/admin/people/permissions`), grant **Administer custom sitemap links** to any
role that should be allowed to manage them. This permission is access-restricted,
so give it only to trusted editors or administrators.

## Verify it worked

Go to `/admin/config/search/simplesitemap/custom-arbitrary-links`. You should see
the custom-links table with an **Add new link** button. See
[Configuration](../configuration/index.md) for how to use it.
