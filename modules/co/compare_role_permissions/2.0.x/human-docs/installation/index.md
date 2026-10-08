# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`) — always present in a standard Drupal install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/compare_role_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/compare_role_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en compare_role_permissions -y
```

## Verify it worked

Under **People → Permissions**, grant the **compare role permissions** permission
to a trusted role, then visit **`/admin/people/permissions/compare`**, pick two
roles, and click **Compare** — you should see a side‑by‑side comparison of their
permissions. See the [overview](../index.md) for how to use the report.
