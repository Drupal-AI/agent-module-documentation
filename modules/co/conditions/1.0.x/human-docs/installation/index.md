# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Plugin form element** module (`plugin_form_element`) — a required
  dependency, pulled in by Composer.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
Plugin form element dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/conditions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en conditions -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Conditions Field** | `conditions_field` | A *Conditions* field type you can attach to any entity via the Field UI, plus widgets/formatter and a service for bulk lookups. Enable this if you want site builders to add a conditions field. |
| **Conditions Test** | `conditions_test` | A test helper used by the module's automated tests. **Do not enable on production sites.** |

To add the field type:

```bash
drush en conditions_field -y
```

## Verify it worked

The base module has no visible UI, so the surest check is that it enabled without
error. If you enabled **Conditions Field**, go to **Structure → *(any entity
type)* → Manage fields → Add field** and confirm **Conditions** appears in the
list of available field types.
