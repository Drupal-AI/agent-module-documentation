# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **Field** module (`field`) — part of core, enabled automatically as a
  dependency.

There are no additional PHP libraries or third‑party Composer requirements. This
project is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/content_connected -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_connected -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_connected -y
```

## Verify it worked

Grant the module's permission (under **People → Permissions**) to the roles that
need it, then open any node and look for the **Content Connected** sub‑tab. Opening
it should show a table of any published content connected to that node — through
entity reference fields, link fields, or long‑text fields. On a node that nothing
references, the table will simply be empty.
