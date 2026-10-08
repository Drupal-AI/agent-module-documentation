# Installation

## Requirements

Contact Storage needs:

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Contact** (`contact`), **Views** (`views`), **Options** (`options`), and
  **Filter** (`filter`) modules — all part of core and enabled automatically as
  dependencies.
- The contrib **Token** module (`drupal/token`, `^1.6`) — pulled in automatically by
  Composer.

There are no PHP library requirements beyond core's.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_storage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the required **Token** module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contact_storage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_storage -y
```

From this point on, messages submitted through your core contact forms are saved
automatically — there's no switch to flip. Make sure you have at least one core
contact form set up (core ships a *Website feedback* form and lets you add more at
*Structure → Contact*).

## Submodules

Contact Storage ships **no submodules**.

## Verify it worked

Submit a test message through one of your contact forms, then go to **Structure →
Contact → List** (`/admin/structure/contact/messages`). The message should appear
in the list, where you can view, edit, or delete it. Continue to
[Configuration](../configuration/index.md) for per‑form options and the global
setting.
