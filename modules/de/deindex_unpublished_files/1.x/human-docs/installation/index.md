# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **File** (`file`) and **Media** (`media`) modules — both are
  dependencies and are enabled automatically.
- **A configured private file system.** For the module to move unpublished files
  into `private://unpublishedfiles/`, your site must have a private file path set
  in `settings.php`, for example:

  ```php
  $settings['file_private_path'] = '../private';
  ```

  Place that directory outside the web root. Without a working `private://`
  stream, the module cannot move files privately and will rely on its `.ht_`
  rename fallback instead.

There are no PHP library or third‑party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/deindex_unpublished_files -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/deindex_unpublished_files -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en deindex_unpublished_files -y
```

Clear caches afterward if needed (`drush cr`).

## Verify it worked

- Confirm your private file system is configured (see Requirements above).
- Go to **Configuration → Media → Unpublished files settings** and confirm the
  settings form loads (see [Configuration](../configuration/index.md)).
- As a test, unpublish a media item whose file is in public storage and check
  that the file is no longer directly downloadable at its old public URL, then
  republish and confirm it is restored. Because the file's URI changes, verify
  that references to it still resolve after the cycle.
