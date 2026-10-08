# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Views** module (`views`) enabled — the only dependency, and part of
  core. Drupal enables it automatically as needed.

There are no third‑party Composer or PHP library requirements.

**Recommended for the hierarchical filter:** the
[CSHS](https://www.drupal.org/project/cshs) (Client‑side Hierarchical Select)
module, which the HS Filter submodule uses to filter views by parent path.

> **Heads up:** this project does not have official security‑advisory coverage.
> Weigh that before relying on it on a high‑stakes production site.

## Install with Composer

From the project root:

```bash
composer require drupal/path_alias_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/path_alias_views -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en path_alias_views -y
```

## Submodules — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Path Alias Views HS Filter** | `path_alias_views_cshs_filter` | A hierarchical filter that lets a view be narrowed by parent path. Best paired with the CSHS module. |

Enable it with:

```bash
drush en path_alias_views_cshs_filter -y
```

## Verify it worked

Go to **Structure → Views → Add view** (`/admin/structure/views/add`). In the
list of things a view can show, you should now see **Path alias**. Create a quick
view of path aliases, add the alias field, and preview it to confirm your
aliases appear.
