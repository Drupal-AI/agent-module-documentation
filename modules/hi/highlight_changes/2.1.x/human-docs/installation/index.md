# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No other modules are required, and there are no third‑party Composer or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/highlight_changes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/highlight_changes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en highlight_changes -y
```

## Grant the permission

Highlight Changes ships its own permission. After enabling the module, go to
**People → Permissions** (`/admin/people/permissions`) and grant it to the roles
whose editors should see change highlighting on entity forms.

## Verify it worked

Edit a piece of content as a user who has the permission. Change any field — a
notice should appear next to it offering a link to view and revert the change.
