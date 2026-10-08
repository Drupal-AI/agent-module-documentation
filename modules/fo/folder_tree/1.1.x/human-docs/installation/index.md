# Installation

## Requirements

Folder Tree needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** module (always present), the only dependency.

There are no third-party Composer or PHP library requirements.

> **Note on security coverage.** This module is not covered by Drupal's security
> advisory policy. Because it exposes server filesystem names to permitted users,
> treat the `access folder tree` permission as sensitive (see Configuration).

## Install with Composer

From the project root:

```bash
composer require drupal/folder_tree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/folder_tree -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en folder_tree -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to set the
root path and grant the permission. Then, as a user who holds the `access folder
tree` permission, open the Folder Tree browser page — you should see the
configured root directory as an expandable tree. Click a folder and confirm its
contents load.
