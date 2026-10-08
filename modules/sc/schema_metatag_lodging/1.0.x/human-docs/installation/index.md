# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Schema.org Metatag](https://www.drupal.org/project/schema_metatag)**
  module (`schema_metatag`) — this module extends it, so it must be present and
  enabled. Schema.org Metatag in turn builds on the
  [Metatag](https://www.drupal.org/project/metatag) module.

There are no third-party PHP libraries to install. The module also works nicely
with the [BEE Hotel](https://www.drupal.org/project/bee_hotel) module, but that is
optional.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_metatag_lodging -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies, including Schema.org Metatag and Metatag if they are not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_metatag_lodging -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module, then enable the **type submodules** for the lodging types
you publish. For example:

```bash
drush en schema_metatag_lodging -y
drush en schema_hotel schema_vacationrental -y
```

## Submodules — enable one per lodging type

| Submodule | Machine name | Schema.org type |
|-----------|--------------|-----------------|
| **Hotel** | `schema_hotel` | `Hotel` |
| **Bed and Breakfast** | `schema_bedandbreakfast` | `BedAndBreakfast` |
| **Vacation Rental** | `schema_vacationrental` | `VacationRental` |

Enable only the ones matching the content you have; the base module supplies the
shared `LodgingBusiness` properties they build on.

## Next step

The module has no settings page of its own — you configure the lodging fields
inside the Metatag UI at **Configuration → Search and metadata → Metatag**. See
the [main guide](../index.md) for the step-by-step walkthrough.
