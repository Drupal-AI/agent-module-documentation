# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **File** (`file`), **System** (`system`), and **Configuration Manager**
  (`config`) modules. File and System are standard; Drupal enables any that are
  missing as dependencies when you turn on this module.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_file_destination -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_file_destination -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_file_destination -y
```

## Assign the permissions

The feature only appears for users who hold its permissions. On **People →
Permissions** (`/admin/people/permissions`), grant:

- `access advanced file destination` — to use the destination chooser at all.
- the **create directories** permission — to make new folders during upload.
- the **private-file access** permission — to target private storage.

Restrict the directory-creation and private-file permissions to trusted roles.
