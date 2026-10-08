# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Block Content** module (`block_content`) — part of core and enabled
  automatically as a dependency.

There are no third-party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/recreate_block_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recreate_block_content -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recreate_block_content -y
```

There is **no settings form, no permissions, and no config to import**. Enabling the
module runs one recreation pass immediately (via its install hook), so any missing block
content that your already-imported config references is recreated right away.

## Next steps

After enabling, you trigger recreation at any later time simply by **clearing caches**
(`drush cr`). This fits neatly at the end of a config-deployment step. See **How to use
it** on the [overview page](../index.md) for the deployment workflow and how to review
what was recreated.
