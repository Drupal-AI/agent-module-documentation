# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a
  dependency.
- The **Taxonomy** module only if you want the taxonomy‑term restriction feature;
  it's a soft dependency, and every other feature works without it.
- If your site runs behind a reverse proxy or CDN, correctly configured
  **`reverse_proxy`** settings in `settings.php` (see the note below).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/internal_network -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/internal_network -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en internal_network -y
```

## Important: get client‑IP detection right behind a proxy

This module decides everything from the visitor's client IP. If your site sits
behind a reverse proxy, load balancer or CDN, Drupal must be told to trust the
proxy so it reads the real client IP from `X-Forwarded-For` — otherwise every
visitor may look like the proxy, or a client could spoof an internal IP. Configure
core's `$settings['reverse_proxy']` and related settings in `settings.php` before
you rely on any restriction. This is a prerequisite for the module to behave
correctly, not optional tuning.

## Verify it worked

Go to **Configuration → System → Internal Network**
(`/admin/config/system/internal-network`). If the settings page opens, the module
is installed. Continue to [Configuration](../configuration/index.md) to set your IP
ranges and choose what to restrict.
