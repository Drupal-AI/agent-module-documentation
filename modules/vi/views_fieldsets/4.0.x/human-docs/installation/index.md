# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9`).
- Core's **Views** module (`views`) enabled — Views Fieldsets is a Views add‑on
  and only makes sense with Views on. To build views through the UI you'll also
  want **Views UI** enabled.

There are no third‑party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/views_fieldsets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_fieldsets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_fieldsets -y
```

Or enable **Views Fieldsets** from **Extend** (`/admin/modules`).

## Next steps

There is nothing to configure globally. Edit a field‑based view, add the
**Global: Fieldset** field, and drag other fields under it on the Rearrange
screen — see [How to use it](../index.md#how-to-use-it) on the overview page.
