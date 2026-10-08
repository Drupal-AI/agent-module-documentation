# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **Taxonomy** module (`taxonomy`).
- The **jQuery UI** module (`drupal/jquery_ui` `^1.7`) — Composer installs it as a
  dependency.
- The **Fancytree** JavaScript library (`fancytree/fancytree`), which powers the
  tree UI. This is a front‑end library the module needs at runtime — install it
  alongside the module (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `jquery_ui` module.

You also need the **Fancytree** library available to Drupal. The usual approach is
to require it through Composer (using the Asset Packagist repository, or a project
that provides it) so it lands in your libraries directory, for example:

```bash
composer require fancytree/fancytree
```

Check the module's own `README` for the exact library placement expected by your
setup. Without Fancytree, the tree interface will not render.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_manager -y
```

## Submodule — merge duplicate terms

An optional submodule folds duplicate terms into one:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Taxonomy Manager Merge** | `taxonomy_manager_merge` | Integrates the [Term Merge](https://www.drupal.org/project/term_merge) module so you can merge duplicate terms into a single target, reassigning their references. |

```bash
drush en taxonomy_manager_merge -y
```

It requires the Term Merge module in addition to the base module.

## Grant permissions

At minimum, users need the **Access taxonomy manager list** permission plus the
relevant core per‑vocabulary term permissions — see the
[Configuration](../configuration/index.md#permissions) page.

## Next steps

Head to **Structure → Taxonomy Manager** to start editing a vocabulary, and see
[Configuration](../configuration/index.md) to tune the settings.
