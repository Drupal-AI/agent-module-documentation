# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11.0`).
- The **Simple XML Sitemap** module (`simple_sitemap`) — required; this module
  extends it.

No external libraries or PHP requirements.

## Install with Composer

If you don't already have Simple XML Sitemap, Composer will pull it in as a
dependency. From the project root:

```bash
composer require drupal/simple_sitemap_exclude -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/simple_sitemap_exclude`,
matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_sitemap_exclude -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_sitemap_exclude -y
```

## Grant the permission

Under **People → Permissions** (`/admin/people/permissions`), grant **Administer
sitemap settings** to any role that should be allowed to edit exclude patterns.

## Verify it worked

Go to `/admin/config/search/simplesitemap/exclude`. You should see the exclude
settings form. See [Configuration](../configuration/index.md) for how to write
patterns.
