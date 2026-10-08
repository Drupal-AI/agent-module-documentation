# Installation

## Requirements

Tokens in Views Filter Criteria needs:

- **Drupal 9.2, 10.1, or 11** (`core_version_requirement: ^9.2 || ^10.1 || ^11`).
- Core's **Views** module enabled (the filters it enhances are Views filters).
- The **Token** module (`drupal/token`, `^1.15`) — its only Composer dependency,
  which Composer installs for you.

Optionally, the **Geofield** module (`drupal/geofield`) enables token support on the
geofield-proximity filter; it is only needed if you use that filter type.

## Install with Composer

From the project root:

```bash
composer require drupal/token_views_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/token_views_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en token_views_filter -y
```

This also enables the Token module if it is not already on. There is no
configuration step — once enabled, the **Use tokens** checkbox appears on the
supported filter types the next time you edit a View. See
[How to use it](../index.md#how-to-use-it) in the overview.
