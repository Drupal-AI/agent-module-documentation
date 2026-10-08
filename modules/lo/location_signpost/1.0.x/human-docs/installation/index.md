# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Block**, **Node**, and **Link** modules (enabled automatically as
  dependencies).
- An **Ordnance Survey Places API key** — sign up with Ordnance Survey to obtain
  one.
- The **Key** module (`drupal/key`) is strongly recommended, so the API key stays
  out of your configuration exports.

The postcodes.io lookup is free and needs no key.

## Install with Composer

From the project root:

```bash
composer require drupal/location_signpost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/location_signpost -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en location_signpost -y
```

## Set up the Key module (recommended)

To keep the OS Places API key out of configuration exports, install and enable the
Key module if it isn't already present:

```bash
composer require drupal/key -W
drush en key -y
```

The [Configuration](../configuration/index.md) guide covers storing the API key as
a Key entity, including how to source it from an environment variable with DDEV.

## Verify it worked

Log in as an administrator, then work through [Configuration](../configuration/index.md)
to store the API key and define at least one area. Place the **Location Signpost**
block on a page and confirm that entering a postcode identifies an area and shows
its signpost links.
