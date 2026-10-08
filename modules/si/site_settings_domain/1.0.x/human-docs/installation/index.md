# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Site Settings** module (`site_settings`) — the module this one extends.
- The **Domain** module (`domain`) — the source of the domain context.

Composer pulls both dependencies in. There are no third-party PHP libraries to install.

Note: this is an **alpha** release and is **not covered by Drupal's security advisory
policy** — the maintainer notes not all functionality has been thoroughly tested yet, so
treat a production install with appropriate care.

## Install with Composer

From the project root:

```bash
composer require drupal/site_settings_domain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — important here, since the module depends on both Site Settings
and Domain.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_settings_domain -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_settings_domain -y
```

Drush enables Site Settings and Domain automatically if they are not already on. If you
enable through the UI at **Extend** (`/admin/modules`), confirm when Drupal offers to
turn on the dependencies.

## After enabling

Make sure your Domain module setup (your domain records) is in place, then create site
settings with a domain context — optionally adding a fallback (no-domain) entry as a
catch-all. Remember to use the **domain-context-aware** site setting loaders and blocks
the module adds, rather than the default Site Settings ones, so per-domain values are
returned correctly.
