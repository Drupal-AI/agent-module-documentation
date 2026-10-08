# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12.0`). This is a
  hard floor — the field type is not available on earlier core.
- Core's **Telephone** module (`telephone`) and **Field** module (`field`) — both
  are declared dependencies and Drupal enables them automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/telephone_e164 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/telephone_e164 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telephone_e164 -y
```

## Verify it worked

Go to a content type's **Manage fields** screen and add a field. The **Telephone
E.164** field type should appear in the list of available field types. Add it, then
try saving a value that is not valid E.164 — it should be rejected.
