# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies and no Composer/PHP library requirements.
- **Recommended:** an in‑memory cache backend — the **APCu** PHP extension, or the
  **Memcache** or **Redis** contrib modules — to hold the rotating salt without
  writing it to disk. On multi‑server sites, prefer Memcache or Redis so the salt
  is shared across web nodes.
- **Recommended:** the **Sodium** PHP extension. When present, Cryptolog uses
  Sodium's BLAKE2b keyed hashes; otherwise it falls back to HMAC‑MD5.

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

Unlike the module's Drupal 7 version, the Drupal 10/11 branch does **not** require
any manual edits to `settings.php` — enabling the module is enough for it to start
replacing client IPs.

## Verify it worked

Trigger some logged activity (for example, load a few pages or attempt a failed
login) and then review **Reports → Recent log messages**
(`/admin/reports/dblog`). The IP addresses recorded there should appear as
pseudonymous identifiers rather than the real client IP. To adjust rotation and
salt storage, see [Configuration](../configuration/index.md).
