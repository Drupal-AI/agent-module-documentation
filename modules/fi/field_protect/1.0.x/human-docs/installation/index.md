# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- Core's **Field** module (`field`), part of a standard Drupal install and enabled
  automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_protect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_protect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_protect -y
```

## Set the permissions

Review the module's permissions at **People → Permissions**
(`/admin/people/permissions`) to fit your workflow. The most relevant one is
**Remember field unlock**, which lets an editor's unlock decision persist so they
don't have to unlock the same field every time. The admin **Forget** action lives on
the settings page and requires **Administer site configuration**.

## Verify it worked

Go to a bundle's **Structure → Content types → *(type)* → Manage form display**,
click the **gear icon** on any widget, and look for a **Field Protect** option
(**"Protect from accidental changes"**). If it's there, the module is installed.
Enable it on a field, save, then open an existing entity's edit form — the field
should appear locked with an **Unlock field** button. See
[Configuration](../configuration/index.md) for the full setup.
