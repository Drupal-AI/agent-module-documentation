# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other modules are required — it builds on core's Field system, and it also
  supports the core/contrib **Media** module (2.x and newer) when your images are
  media references.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/representative_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/representative_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en representative_image -y
```

This makes the **Representative Image** field type available to add to your
bundles.

## Verify it worked

Go to **Structure → Content types → *(a type)* → Manage fields → Add field** and
confirm **Representative Image** appears as a field type you can add. Then follow
[Configuration](../configuration/index.md) to point it at an image field and start
using its token.
