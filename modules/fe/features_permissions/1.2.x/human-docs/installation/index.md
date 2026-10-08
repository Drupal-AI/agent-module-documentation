# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10.0 || ^11.0`).
- The **Features** module (`features`) — a hard dependency, pulled in by Composer.
- No third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/features_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will bring in the Features module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/features_permissions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en features_permissions -y
```

This enables Features Permissions (and Features if it was not already on). From this
point the module keeps permission configuration entities in sync with your roles.

## Verify it worked

Go to **Configuration → Development → Features**
(`/admin/config/development/features`) and build or edit a Feature. Permission
configuration entities should now be available to include, so you can export a
Feature's permissions independently of its roles. Confirm that importing such a
Feature grants only those permissions and leaves the role's other permissions
unchanged.
