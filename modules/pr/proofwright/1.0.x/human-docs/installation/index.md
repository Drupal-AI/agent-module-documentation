# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or later.**
- A **console endpoint** to receive the SBOM. A hosted account is available at
  proofwright.eu, and the module works standalone against any endpoint that implements
  the documented ingest API.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/proofwright -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/proofwright -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en proofwright -y
```

## Verify it worked

Log in as an administrator and visit
**Configuration → System → Proofwright** (`/admin/config/system/proofwright`).
If the settings form loads, the module is installed. Nothing is sent anywhere until
you fill in the console URL and licence key — see
[Configuration](../configuration/index.md).
