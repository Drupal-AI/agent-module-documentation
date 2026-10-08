# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Simple XML Sitemap** module (`simple_sitemap`) — this module builds its
  per‑domain variants on top of it.
- The **Domain Access** module (`domain_access`) — the source of the domains each
  sitemap variant is tied to.
- Optionally, **Domain Configuration** (`domain_config`) or **Domain Site
  Settings** (`domain_site_settings`) if you want to use the "replace homepage"
  option — without one of these, that toggle stays disabled.

Both `simple_sitemap` and `domain_access` must be present; Drupal treats them as
dependencies and will enable them when you turn this module on.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_simple_sitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Make sure `drupal/simple_sitemap` and `drupal/domain` (the
project that provides Domain Access) are installed too — require them the same way
if they aren't already.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_simple_sitemap -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_simple_sitemap -y
```

## After enabling

If your site already has domains defined, open **Configuration → Domain → Domain
Access Simple Sitemap** and click **Generate domain's sitemap variants** to create
a variant for each existing domain. New domains added later get their variants
automatically. Then continue with [Configuration](../configuration/index.md) for
the two toggles and the full end‑to‑end setup.
