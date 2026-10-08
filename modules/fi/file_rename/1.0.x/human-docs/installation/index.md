# Installation

## Requirements

- **Drupal 9.3, 10 or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **File** module (`file`), which is enabled on any site that handles
  uploads. Drupal enables it automatically as a dependency.

There are no third-party Composer packages and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/file_rename -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/file_rename -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_rename -y
```

## First steps after enabling

File Rename does two things out of the box, but you'll want to set it up properly:

1. **Grant the permission.** Renaming is locked behind the *Rename files*
   permission, which no role has by default. Until you grant it, the *Rename*
   links won't appear for anyone. See [Configuration](../configuration/index.md).
2. **Choose where the widget link shows.** By default the global setting makes a
   *Rename* link appear under uploaded files on every file/image widget. You can
   narrow this to specific fields or turn it off — again see
   [Configuration](../configuration/index.md).

## Verify it worked

Log in as an administrator (who has all permissions) and go to **Content → Files**
(`/admin/content/files`). Each permanent file's operations menu should now include
a **Rename** link. Click it, change the base filename, and save — the file is
renamed on disk and in Drupal.
