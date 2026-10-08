# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **Address** module (`address`) enabled — a required dependency, and the field
  this module enhances. Composer pulls it in automatically.
- Access to a **Photon endpoint** — either a public Photon instance or, preferably,
  your own self-hosted one (see [Configuration](../configuration/index.md)).

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/address_autocomplete_photon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `address` dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_autocomplete_photon -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_autocomplete_photon -y
```

Drush enables the `address` dependency at the same time.

## Optional: the geofield submodule

If you want to store geographic coordinates alongside the selected address, enable
the bundled submodule:

```bash
drush en address_autocomplete_photon_geofield -y
```

Next, set the Photon endpoint and turn on the autocomplete widget for your Address
field — see [Configuration](../configuration/index.md).
