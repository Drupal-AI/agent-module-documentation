# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Migrate** module (`migrate`) enabled — this is the only dependency,
  and there are no additional requirements.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_log_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_log_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_log_ui -y
```

Core Migrate is enabled automatically if it is not already on.

## Grant the log‑viewing permission

Migrate log UI adds a **`view migrate log messages`** permission that gates both
of its pages. At **People → Permissions** (`/admin/people/permissions`), tick it
for the roles that should be able to read migration messages — typically your
developers and site builders. Until a role has this permission, its members
cannot reach the overview or the message viewer.

## Verify it worked

Log in as a user with the permission and visit
`/admin/migrate/log_ui/migration`. You should see the overview page listing your
migrations and their counts. Click a migration to open its filterable message
log. There is no configuration form to fill in.
