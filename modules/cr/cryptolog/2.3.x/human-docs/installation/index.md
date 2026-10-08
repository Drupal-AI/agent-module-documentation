# Installation

## Requirements

- **Drupal 11.2 or newer, or Drupal 12** (`core_version_requirement: ^11.2 || ^12`).
- **PHP compiled with IPv6 support** — this is an install requirement, because the
  pseudonymous identifiers are rendered in IPv6 notation.
- No module dependencies and no Composer/PHP library requirements.
- **Recommended:** an in‑memory cache backend — the **APCu** PHP extension, or the
  **Memcache** or **Redis** contrib modules — to hold the rotating salt without
  writing it to disk. On multi‑server sites, prefer Memcache or Redis so the salt
  is shared across web nodes.
- **Recommended:** the **Sodium** PHP extension. When present, Cryptolog uses
  Sodium's `sodium_crypto_generichash`; otherwise it falls back to HMAC‑MD5.

## Install with Composer

From the project root:

```bash
composer require drupal/cryptolog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cryptolog -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cryptolog -y
```

Enabling the module is enough — the HTTP middleware that replaces client IPs is
registered automatically, with no `settings.php` changes required.

## Verify it worked

Trigger some logged activity (for example, load a few pages or attempt a failed
login) and then review **Reports → Recent log messages**
(`/admin/reports/dblog`). The IP addresses recorded there should appear as
pseudonymous identifiers rather than real client IPs. To tune salt storage and
rotation, see [Configuration](../configuration/index.md).
