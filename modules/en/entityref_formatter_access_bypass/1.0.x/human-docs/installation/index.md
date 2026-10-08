# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No other contrib modules and no PHP or Composer libraries are required — it
  extends core's Entity Reference and Field UI.

## Install with Composer

From the project root:

```bash
composer require drupal/entityref_formatter_access_bypass -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entityref_formatter_access_bypass -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entityref_formatter_access_bypass -y
```

## Verify it worked

Go to a bundle's **Manage display** (**Structure → *(entity type)* → *(bundle)* →
Manage display**), find an entity reference field, and open its format list. The
**Rendered entity with access bypass fallback** formatter should now be
available.

> **Before you switch any field to it**, review the security warning in the
> [guide](../index.md#-read-this-before-you-enable-it): this formatter renders
> referenced entities regardless of the viewer's access, so configure the
> fallback view mode to contain only fields that are safe for anyone to see.
