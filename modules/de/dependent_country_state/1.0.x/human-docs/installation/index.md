# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other contrib modules are required — the module manages its own custom
  database tables and needs no third-party Composer or PHP libraries.

Note that this project is **not covered by Drupal's security advisory policy**,
so review it yourself before relying on it in a sensitive environment.

## Install with Composer

From the project root:

```bash
composer require drupal/dependent_country_state -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dependent_country_state -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dependent_country_state -y
```

Enabling the module runs its install step, which **creates the four custom tables**
(`dependent_country`, `dependent_state`, `dependent_city`, `dependent_pincode`) and
**seeds the default data** — a full list of countries and all Indian states.
Cities and pincodes start empty.

## Grant permissions

This module ships several restricted permissions. Under **People → Permissions**
grant them deliberately:

- **`dependent country state administrator`** — access the admin CRUD, list and
  bulk-import screens under **Configuration → Country, state and city**.
- **`country api access`**, **`state api access`**, **`city api access`**,
  **`areapincode api access`** — call the corresponding JSON endpoints. Grant only
  the ones your integration uses, and only to the roles that need them.

## Verify it worked

Log in as an administrator and go to **Configuration → Country, state and city**.
You should see the country and state lists already populated with the seeded
defaults. To confirm the API works, request an endpoint you have permission for,
for example `/admin/city-state-city/api/get-country`, and check that it returns
JSON.
