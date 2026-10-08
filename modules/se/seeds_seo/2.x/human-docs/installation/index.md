# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Contrib modules** it depends on and enables: Metatag (`metatag`) plus its
  Facebook (`metatag_facebook`) and Open Graph (`metatag_open_graph`) submodules,
  Simple XML Sitemap (`simple_sitemap`), Redirect (`redirect`), Pathauto
  (`pathauto`), Link Attributes (`link_attributes`), and Length Indicator
  (`length_indicator`). Composer installs these for you.

There are no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/seeds_seo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the bundled SEO
modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/seeds_seo -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seeds_seo -y
```

Enabling Seeds SEO also enables all of the bundled SEO modules and applies its
baseline configuration.

## Verify it worked

Check **Extend** (`/admin/modules`) to confirm the SEO modules are enabled. Then
review the configuration Seeds SEO applied — Metatag defaults, Pathauto URL
patterns, and the sitemap — and tailor them to your site. Seeds SEO has no
settings page of its own; all tuning happens in the modules it brought in.
