# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Drupal Commerce** (`commerce`) — the only dependency.

There are no third‑party Composer or PHP library requirements (it uses PHP's
built‑in OpenSSL functions).

> **Note:** this module is currently **not covered by Drupal's security advisory
> policy**, and its order‑ID token is obfuscation only (the key/IV are hard‑coded).
> Do not treat it as an access boundary.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_url -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_url -y
```

That's all — there is no configuration step. URL hashing is active immediately.

## Verify it worked

Start a checkout and look at the address bar: the order‑ID segment should now be an
encrypted token (`/checkout/{token}/order_information`) rather than a plain number,
and the checkout steps should still work. Disable the module to revert to plain
numeric URLs.
