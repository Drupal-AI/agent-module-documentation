# Installation

## Requirements

Subresource Integrity UI is lightweight:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, and no third-party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/sri_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sri_ui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sri_ui -y
```

Or enable **Subresource Integrity UI** from the Extend page (`/admin/modules`).

## Verify it worked

Log in as a user with the **Administer site configuration** permission and visit
**Configuration → Web services → SRI** (`/admin/config/services/sri`). If the
form for entering an asset URL appears, the module is installed and ready — see
[Configuration](../configuration/index.md) to generate your first hash.
