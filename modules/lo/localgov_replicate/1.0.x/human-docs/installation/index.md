# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contrib **Replicate** (`replicate`) and **Replicate UI** (`replicate_ui`)
  modules — these provide the actual clone route, tab and permission. Composer and
  Drupal pull them in as dependencies.
- A **LocalGov Drupal** site — the module grants its default permissions to LocalGov
  roles, so it is designed for the distribution.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_replicate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Replicate and
Replicate UI alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_replicate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_replicate -y
```

Drupal enables Replicate and Replicate UI at the same time.

## For LocalGov Microsites

On a LocalGov Microsites site, also enable the microsites submodule, which grants
clone access to the **Microsites Controller** and **Microsites Editor** roles:

```bash
drush en localgov_replicate_microsites -y
```

## After enabling

By default all content types are replicatable and only the **LocalGov Editor** role
can clone. Adjust which roles hold the **Replicate entities** permission at
**People → Permissions** (`/admin/people/permissions`), under the **Replicate**
section.

## Verify it worked

Log in as a **LocalGov Editor** and open any node. You should see a **Clone** tab.
Click it, confirm, and check that a duplicate of the content is created.
