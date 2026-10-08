# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No dependent modules, no PHP libraries, and no third‑party Composer packages —
  dependencies are core only.

Before you deploy this on a proxied site, make sure your `settings.php` reverse‑proxy
configuration (`reverse_proxy` / `trusted_hosts`) is correct — see the caveats in the
[main guide](../index.md) and [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/simple_ip_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_ip_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_ip_login -y
```

## Verify it worked

After enabling, go to **Configuration → System → Simple IP Login**. If the IP
Wildcard collection loads, the module is installed. No auto‑login happens until you
add at least one IP Wildcard rule — see [Configuration](../configuration/index.md),
and read the safety notes there before mapping any IP to an account.
