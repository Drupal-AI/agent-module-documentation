# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The `yourivw/LEClient` PHP library (an ACME v2 client), pulled in by Composer.
- **Access to the web server or to DNS management** so the domain can be verified
  as accessible/owned — HTTP‑01 challenges need the web server to serve challenge
  files; wildcard certificates need a DNS callback.
- **Filesystem write access** for the server so it can write challenge files and
  store certificates and keys.

## Install with Composer

From the project root:

```bash
composer require drupal/letsencrypt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `LEClient`
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/letsencrypt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en letsencrypt -y
```

## Verify it worked

Go to **Configuration → System → Letsencrypt**
(`/admin/config/system/letsencrypt`) and confirm the settings/demo page loads.
From there you can attempt a certificate for a domain you control — see
[Configuration](../configuration/index.md).
