# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. Because it customizes the country list used by country and address
fields, it is most useful on a site that actually uses such fields (for example
via core's country support or the Address module).

## Install with Composer

From the project root:

```bash
composer require drupal/country_alter_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/country_alter_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en country_alter_ui -y
```

## Verify it worked

After enabling, open the Country Alter UI screen from the **Configuration** area of
the admin menu. Disable or rename a country there, save, and then check a country
or address field on your site — it should reflect the change.
