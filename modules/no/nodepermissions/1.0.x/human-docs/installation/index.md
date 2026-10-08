# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1||^11||^12`).
- Core's **Node** module (`node`) — present on any standard Drupal site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/nodepermissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nodepermissions -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nodepermissions -y
```

## Verify it worked

Go to the module's permissions page at
`/admin/people/permissions/module/nodepermissions`. You should see the new per‑field
permissions — for author (`uid`), status, created date, promote, and sticky. Grant them
to the appropriate roles and test that each role can edit only the fields you intended.
See the [overview](../index.md) for guidance on assigning them safely.
