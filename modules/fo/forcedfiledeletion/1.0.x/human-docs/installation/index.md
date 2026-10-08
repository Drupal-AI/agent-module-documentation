# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies.

> **Not security‑advisory covered.** This project is marked
> `security_advisory_coverage: not-covered`. Combined with what it does —
> permanently deleting files — treat it with extra care and restrict its
> permission tightly.

## Install with Composer

From the project root:

```bash
composer require drupal/forcedfiledeletion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/forcedfiledeletion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en forcedfiledeletion -y
```

## Grant the permission — carefully

The module adds a **"forcibly delete a file"** permission. This permission lets a
user delete a file even when its usage count is non‑zero, permanently and
irreversibly. Grant it at **People → Permissions**
(`/admin/people/permissions`) to **trusted administrators only**.

## Verify it worked

As a user with the permission, open a managed file that has usage and start its
delete flow. You should see the module's adjusted warning and button text
indicating the deletion will be forced. (Do not confirm on a file you actually
need — the deletion cannot be undone.)
