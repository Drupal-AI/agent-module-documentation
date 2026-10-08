# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8** or newer (`php_requirement: ^8`).
- Drupal core's **Field** (`field`) and **Media** (`media`) modules — Media
  handles the image uploads in the 3.x branch.
- The contributed **Context** module (`context`) — used to decide which background
  image shows in which context.

The 3.x branch also uses core's Responsive Image styles for responsive/retina
delivery. Note the module loads a jscolor color picker from a public CDN (with a
Subresource Integrity hash) for the admin color controls.

## Install with Composer

From the project root:

```bash
composer require drupal/background_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies, including Context.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/background_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en background_image -y
```

This enables Media and Context if they aren't already on. After enabling, grant
the **Administer background image** permission to a trusted role, upload a
background image, and place it with Context — see the
[overview](../index.md#how-to-use-it) for the walk‑through.
