# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`).
- The contributed **Migrate File** module (`migrate_file`) — used for the
  file‑handling side of the import.

There are no additional PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_inline_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate File and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_inline_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_inline_image -y
```

Drupal enables core Migrate and Migrate File automatically as dependencies if
they are not already on.

## Verify it worked

Confirm the module and Migrate File are enabled (**Extend** page, or
`drush pm:list --status=enabled`). There is no configuration form to visit — the
`save_inline_image` process plugin becomes available for use in your migration
YAML, where you set its required `image_file_source_path` and
`image_file_save_destination` keys (see "How to use it" on the
[overview page](../index.md)).
