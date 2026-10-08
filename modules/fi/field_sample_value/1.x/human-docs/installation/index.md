# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).

There are no other module dependencies and no third‑party libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/field_sample_value -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_sample_value -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_sample_value -y
```

## Verify it worked

Edit any field on a content type (**Structure → Content types → *(type)* → Manage
fields → *(field)***). The field's configuration page should now show the **Field
Sample Value** options for choosing a sample value generator.
