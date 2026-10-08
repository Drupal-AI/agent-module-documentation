# Installation

## Requirements

Hide Non‑Editable Content relies only on core modules:

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Views** (`views`) and **Node** (`node`) modules — both are dependencies
  and are enabled automatically if not already on.

There are no third‑party Composer or PHP library requirements.

> **Note:** This module is **deprecated and unsupported**. Its maintainer points to
> [Content View Bundle Permissions](https://www.drupal.org/project/content_view_bundle_permissions)
> as a better‑maintained alternative — consider it for new projects, especially on
> Drupal 11.

## Install with Composer

From the project root:

```bash
composer require drupal/hide_non_editable_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hide_non_editable_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hide_non_editable_content -y
```

That is the whole setup — there is nothing to configure.

## Verify it worked

Log in as a user who can edit only some content types (for example an editor with
"edit own" rights on one bundle) and visit **`/admin/content`**. The list should show
only the nodes that user can edit or delete, and the **Type** filter should offer
only the matching content types. An administrator with full rights should still see
everything.
