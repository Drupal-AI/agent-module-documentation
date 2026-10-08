# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

Paragon Core has no third‑party Composer or PHP library requirements. It is
designed to be enabled as a base dependency of other Paragon packages.

## Install with Composer

From the project root:

```bash
composer require drupal/paragon_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragon_core -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragon_core -y
```

That is all it takes — there is no configuration to complete.

## Verify it worked

Log in as an editor or administrator and open any node. Look at the row of tabs at
the top of the page: the moderation tab should read **"Preview"** and appear first,
the revisions tab should read **"Version History"**, and the **"Delete"** tab
should no longer be in the tab bar. (You can still delete the node through its
normal delete route if you have permission — the tab is only hidden, not the
capability.)
