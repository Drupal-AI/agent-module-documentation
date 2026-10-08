# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third‑party PHP libraries — it uses Drupal's built‑in HTTP client (Guzzle).
- Optionally, an **ip-api.com API key** if you want the paid `pro.ip-api.com`
  tier; the free tier needs no key.

## Install with Composer

From the project root:

```bash
composer require drupal/ip_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ip_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ip_api -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → System → IP API**
(`/admin/config/system/ip-api`). If the settings form loads, the module is
installed. To confirm it works end to end, call the `ip_api.geolocation` service
from a small piece of custom code and check that `isRequestSuccessful()` returns
true.

> **Note:** this module is not covered by Drupal's security advisory policy, and
> its outbound calls are unencrypted — read [Configuration](../configuration/index.md)
> before using it with a paid API key.
