# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is enabled on every Drupal site.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/role_hierarchy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_hierarchy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_hierarchy -y
```

## Set it up

Enabling the module does not change anything on its own — the hierarchy is defined
by the **order of your roles**, and the module's own settings object isn't even
created until you save the People → Roles form once. So the important next step is:

1. Go to **People → Roles** (`/admin/people/roles`).
2. Drag your roles into order of authority (higher in the list = more powerful).
3. Adjust the **Role hierarchy** options if needed and **Save**.

See [Configuration](../configuration/index.md) for the details of each option, and
review the **Bypass role hierarchy** permission — grant it only to administrators
whose edit rights should be governed by other permissions instead.
