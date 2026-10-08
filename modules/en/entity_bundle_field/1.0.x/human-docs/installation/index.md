# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No module dependencies and no third‑party library requirements.

> **Note:** This project is not covered by Drupal's security advisory policy. Review
> it against your own site's requirements before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_bundle_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_bundle_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_bundle_field -y
```

## Verify it worked

Go to any entity's **Manage fields → Add field** screen. The field type list should
now include **Entity Bundle Reference**. Add it, choose which bundles it references,
and save to confirm the field type is available.
