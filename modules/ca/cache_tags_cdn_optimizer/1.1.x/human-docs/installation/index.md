# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`; the module also reports
  compatibility with 12).
- No other modules, third-party Composer packages, or PHP libraries are required.
- To see the benefit, the site should sit behind a **CDN or reverse proxy** that
  purges on Drupal's cache tags.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_tags_cdn_optimizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_tags_cdn_optimizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_tags_cdn_optimizer -y
```

That is all. There is no configuration — the optimizer adjusts cache tags for
referenced entities automatically from the moment it is enabled.
