# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`) — enabled on every Drupal site by default.
- **Optional:** [**Advanced Help**](https://www.drupal.org/project/advanced_help)
  (`drupal/advanced_help`) — if enabled, the project README is shown in the help
  system.
- **Optional:** [**RoleAssign**](https://www.drupal.org/project/roleassign)
  (`drupal/roleassign`) — used together with the bundled
  `roleassign_with_user_csv_import` submodule (below).

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/user_csv_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/user_csv_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en user_csv_import -y
```

An **Import users from CSV** action link now appears on the People page
(`/admin/people`), available to anyone with the core **Administer users** permission.

## Optional submodule — RoleAssign integration

The package ships one submodule, **`roleassign_with_user_csv_import`**. When enabled
(alongside the contributed **RoleAssign** module), it limits the roles offered on the
import form to those the current user is allowed to assign — handy when delegated
administrators run imports.

```bash
drush en roleassign_with_user_csv_import -y
```
