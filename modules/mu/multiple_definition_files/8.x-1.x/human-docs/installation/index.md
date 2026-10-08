# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Layout Discovery** module (`layout_discovery`), which Drupal enables
  automatically as a dependency.
- No third‑party Composer packages or external libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/multiple_definition_files -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multiple_definition_files -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiple_definition_files -y
```

That's all — there is no configuration to do.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`) or with
`drush pml --filter=multiple_definition_files`. To confirm it is actually doing
its job, split one theme's library or layout definitions into a second file and
clear caches (`drush cr`); the definitions from the additional file should still
load correctly.
