# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **[Admin Audit Trail](https://www.drupal.org/project/admin_audit_trail)**
  module (`admin_audit_trail`) enabled. This is the module whose log these config
  entries are written into, and Composer pulls it in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_audit_trail_config_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update Admin
Audit Trail and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_audit_trail_config_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_audit_trail_config_sync -y
```

That is all. There is no configuration form, no permission, and no submodules. From
now on, configuration imports — including those run from the command line — are
logged into Admin Audit Trail under the **Config Sync** event type. To confirm it
worked, run `drush config:import` and check the audit overview for a new entry.
