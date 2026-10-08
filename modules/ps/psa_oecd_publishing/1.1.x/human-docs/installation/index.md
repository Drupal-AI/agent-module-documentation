# Installation

## Requirements

- **Drupal 10.5 or 11.2 and newer** (`core_version_requirement: ^10.5 || ^11.2`).
- Core's **Node**, **User**, and **Views** modules — enabled automatically as
  dependencies.
- An **API key** for the OECD GlobalRecalls portal (production and/or testing), which
  you enter during configuration.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/psa_oecd_publishing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/psa_oecd_publishing -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en psa_oecd_publishing -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → OECD GlobalRecalls
API** (`/admin/config/services/psa-oecd-publishing`). If the settings form loads, the
module is installed. Continue with [Configuration](../configuration/index.md) to enter
your API key and map your fields.
