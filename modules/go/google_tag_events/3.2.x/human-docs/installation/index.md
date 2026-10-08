# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Google Tag** module (`google_tag`) — this `3.2.x` release requires Google
  Tag **2.0.x**. (The older `2.x` branch of this module was for Google Tag
  8.x-1.x.)
- The **JS Cookie** module (`js_cookie`, `^1`) — used for the cookie-backed
  cross-request event store.

Composer resolves and installs `drupal/google_tag` and `drupal/js_cookie` for you.

## Install with Composer

From the project root:

```bash
composer require drupal/google_tag_events -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_tag_events -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_tag_events -y
```

This also enables Google Tag and JS Cookie if they are not already on.

## Verify it worked

Go to **Configuration → Services → Google Tag → Events → Settings**
(`/admin/config/services/google-tag/events/settings`). If the form loads, the
module is installed — next, configure a GTM container or enable debug mode as
described in [Configuration](../configuration/index.md).
