# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`). To add and manage the field in the UI you
  will also want core's **Field UI** enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_font -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_font -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_font -y
```

## Grant the permission

Field Font adds an **Access font fields** permission. At **People → Permissions**
(`/admin/people/permissions`), grant it to the roles that should be able to use
font fields — otherwise those users will not be able to access the field.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**
and confirm that **Font** appears among the available field types. Add one, grant
the **Access font fields** permission to your role, and check that you can choose
a font on the content edit form and see it applied to the rendered page.
