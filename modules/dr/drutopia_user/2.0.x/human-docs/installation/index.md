# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core modules **Field** (`field`), **File** (`file`), **Image** (`image`),
  **Path** (`path`), and **User** (`user`). These ship with Drupal core, and
  Drupal enables any that are off automatically when you turn on Drutopia User.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_user -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drutopia_user -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_user -y
```

On enable, the module imports its display configuration for the user entity —
the default profile view display, the default account form display, and a
**compact** user view mode.

## Verify it worked

Visit **Structure → Account settings → Manage display**
(`/admin/config/people/accounts/display`). You should see the shipped field
arrangement, and a **Compact** view mode available in the list of view modes.
Check **Manage form display** too to confirm the account form order was applied.
That is all the setup this configuration‑only feature needs.
