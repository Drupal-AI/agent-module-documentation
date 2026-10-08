# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11**
  (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Migrate** module for the actual migration run (this module lists no
  explicit dependencies, but the plugin is only useful within a Migrate pipeline,
  and it stands in for core's `file_copy`).

There are no third‑party Composer libraries. This is a **development** tool — do
not enable it where real files must be copied.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_devel_file_copy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_devel_file_copy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_devel_file_copy -y
```

## Verify it worked

There is no admin page. Add the `hook_migrate_process_info_alter()` swap (see
[the module overview](../index.md#how-to-use-it)) or reference
`file_copy_or_generate` directly, then run a file migration against a source that
is missing some files — confirm the migration completes and placeholder files are
generated instead of erroring out.
