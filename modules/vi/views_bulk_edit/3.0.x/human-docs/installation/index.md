# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- No hard module dependencies — VBE runs on Drupal core alone.

**Strongly recommended companion:** [Views Bulk Operations](https://www.drupal.org/project/views_bulk_operations)
(`views_bulk_operations`, VBO). It isn't required, but it's what gives you
batching for large edits, the "select all results in this view" option, and a
selection that persists across paged results. Without it, VBE falls back to a
core‑only Action and the confirm form at `/admin/content/bulk-edit`.

## Install with Composer

From the project root:

```bash
composer require drupal/views_bulk_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To install the recommended companion at the same time:

```bash
composer require drupal/views_bulk_edit drupal/views_bulk_operations -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_bulk_edit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_bulk_edit -y
```

And, if you installed it, enable VBO as well:

```bash
drush en views_bulk_operations -y
```

## Grant the permission

If you use the core‑only confirm form at `/admin/content/bulk-edit`, grant the
**Allow bulk edit of entities** permission (`use views bulk edit`) to the roles
that should be able to bulk‑edit — for example:

```bash
drush role:perm:add editor 'use views bulk edit'
```

Remember that this permission only opens the confirm form; each entity is still
checked individually for edit access, so users can only change content they
could already edit.

## Submodules

Views Bulk Edit ships no submodules.
