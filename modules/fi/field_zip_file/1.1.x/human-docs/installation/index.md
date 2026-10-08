# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** (`field`) and **File** (`file`) modules, which Drupal enables
  automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_zip_file -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_zip_file -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_zip_file -y
```

## Set permissions

The module provides its own permissions, including a **bypass content
restrictions** permission. Review them at **People → Permissions**
(`/admin/people/permissions`) and grant upload/bypass capabilities only to roles
you trust — extracted archives can contain HTML/JavaScript that would then be
served from your domain.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**. The
**Zip File** field type should be listed. Add it, configure its forbidden
extensions, then create content and upload a `.zip` to confirm it extracts on save.
