# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **RESTful Web Services** module (`rest`) — a hard dependency, and part of
  Drupal core. You will also want core's **Serialization** and **Views** modules,
  which REST exports rely on.
- No third‑party Composer or PHP library requirements.

> **Note:** This release is an alpha (`1.0.0-alpha16`) and is minimally
> maintained. Test the endpoints it produces before relying on them in production.

## Install with Composer

From the project root:

```bash
composer require drupal/informea_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/informea_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en informea_api -y
```

Enabling it will also enable core REST if it is not already on. Enable Views and
Serialization too if your site does not already have them.

## Verify it worked

There is no settings page to check. Instead, go to **Structure → Views**, create a
View, add a REST export display, and confirm the **InforMEA serializer** appears as
an available format option. If it does, the module is installed and ready — see
"How to use it" on the [overview page](../index.md) to build your first endpoint.
