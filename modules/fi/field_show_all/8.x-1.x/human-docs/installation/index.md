# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no other module dependencies and no third‑party libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/field_show_all -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_show_all -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_show_all -y
```

## Verify it worked

Go to a **Manage display** screen (**Structure → Content types → *(type)* → Manage
display**) and open the **Format** dropdown for a multi‑value field. The **Field
Show All** formatter should be listed as an option.
