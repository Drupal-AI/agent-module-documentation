# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no third‑party Composer or PHP library requirements, and the module
depends on no external service.

## Install with Composer

From the project root:

```bash
composer require drupal/openfed_social -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openfed_social -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openfed_social -y
```

## Choose networks and place the block

1. Go to **Configuration → Web services → Openfed Social**
   (`/admin/config/services/ofed_social`) and select which social networks to
   offer. Keep the theme set to **default** unless you're migrating from the old
   ShareThis module.
2. Place the **Openfed Social Block** into a region at **Structure → Block
   layout** (`/admin/structure/block`) so the share links appear on your pages.

## Verify it worked

Visit a front‑end page and look for the share links in the region where you placed
the block. Clicking one should open the corresponding network's share dialog for
the current page. To customise the appearance, override the
`ofed-social-links-default.html.twig` template in your theme.
