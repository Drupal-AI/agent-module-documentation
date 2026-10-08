# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required. To benefit from the fix on the *latest revision*
  tab you will want core's **Content Moderation** module, but it is not a hard
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/revision_menu_trail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revision_menu_trail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revision_menu_trail -y
```

## Verify it worked

View an older revision of a node (or the **Latest version** tab of a moderated
node). The active menu highlighting and breadcrumb should now match that revision,
and any menu blocks on the page should highlight the correct item. There is nothing
to configure.
