# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No module dependencies beyond core, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_unrestricted_label -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_unrestricted_label -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_unrestricted_label -y
```

## A word of caution before you use it

This module's formatter **bypasses entity access** to show labels. Enabling the
module does nothing on its own — the disclosure only happens once you select the
**Label (access bypass)** formatter on a field. Before you do, make sure the
referenced entities' labels are not sensitive. See the [overview](../index.md) for
the full access consideration.

## Verify it worked

Go to **Structure → Content types → *(any type with a reference field)* → Manage
display**. Open the **Format** dropdown for that field — **Label (access bypass)**
should now appear as an option. Its presence confirms the module is installed.
