# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, and no third-party Composer or PHP library
  requirements.
- Outbound HTTPS access from the server to the external CEP service (e.g. ViaCEP)
  the lookup calls — without it, the postal-code auto-fill cannot work.

## Install with Composer

From the project root:

```bash
composer require drupal/br_address_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/br_address_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en br_address_field -y
```

There is no settings page. Once enabled, add the Brazilian address field to a
content type through the **Field UI** (Structure → your content type → Manage
fields → Add field) — see the [overview](../index.md#how-to-use-it).
