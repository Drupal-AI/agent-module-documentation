# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules, PHP libraries, or external services are required. The block draws
  the site name and slogan from core's **Basic site settings** and the logo from your
  active theme, both of which every Drupal site already has.

## Install with Composer

From the project root:

```bash
composer require drupal/site_branding_per_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_branding_per_role -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_branding_per_role -y
```

## Verify it worked

The module adds no admin menu item of its own. To confirm it is active, go to
**Structure → Block layout** and check that **Site branding per role block** appears in
the list of blocks you can place. Placing and configuring it is covered in
[Configuration](../configuration/index.md).
