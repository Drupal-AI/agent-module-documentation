# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Field** (`field`), **System** (`system`) and **User** (`user`) modules —
  Drupal enables these automatically as dependencies.
- A source of the visitor's **country code in a request header**. This usually comes from
  a CDN or reverse proxy (for example Cloudflare's `HTTP_CF_IPCOUNTRY`) or from your own
  edge configuration — Page Geofence reads the header but does not itself perform IP
  geolocation.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pagegeofence -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagegeofence -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagegeofence -y
```

## After installation

1. Make sure your CDN/proxy is passing the visitor's country in a request header, and
   that Drupal's **trusted proxy** settings are configured so the real client IP is
   trusted.
2. Grant this module's permission to trusted administrators at **People → Permissions**
   (`/admin/people/permissions`).
3. Create your geofence rules — see [Configuration](../configuration/index.md).

## Verify it worked

Because nothing is geofenced by default, the module has no visible effect until you add a
rule. After creating one, test it (ideally from an IP/country matching and not matching
the rule) and confirm blocked visitors get the redirect or 403 you configured.
