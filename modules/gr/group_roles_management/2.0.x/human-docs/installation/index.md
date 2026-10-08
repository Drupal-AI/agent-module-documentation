# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **PHP 8.3** or newer — this module requires it.
- The **[Group](https://www.drupal.org/project/group)** module (`group`). Use this
  **2.0** release with Group 2.0 or Group 3.0; for Group 1.0 use Group roles
  management 1.0 instead.

There are no third‑party Composer or PHP library requirements beyond the PHP
version.

## Install with Composer

From the project root:

```bash
composer require drupal/group_roles_management -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_roles_management -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_roles_management -y
```

## Verify it worked

Open one of your group types' **permissions** pages. You should see new per‑role
member‑management permissions provided by this module. Grant one to a test group
role, then confirm a user with that role can manage members of the targeted role —
and *cannot* manage members of roles you didn't delegate.
