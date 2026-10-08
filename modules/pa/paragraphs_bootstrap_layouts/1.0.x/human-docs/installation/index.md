# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`).
- The [Classy Paragraphs](https://www.drupal.org/project/classy_paragraphs) module
  (`classy_paragraphs`) — it provides the class‑selection mechanism this module
  builds on.
- A **Bootstrap‑compatible theme**, because the layout relies on Bootstrap row and
  column CSS classes.

There are no third‑party Composer or PHP library requirements beyond the Drupal
modules above.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_bootstrap_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Classy Paragraphs
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_bootstrap_layouts -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en paragraphs_bootstrap_layouts -y
```

## Submodules — enable one grid

The base module ships two submodules that carry the grid configuration. Enable
**one**, matching the grid your design uses:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| 12‑column grid | `paragraphs_bootstrap_layouts_12_col` | Classy Paragraphs configuration for a standard Bootstrap 12‑column grid. |
| 24‑column grid | `paragraphs_bootstrap_layouts_24_col` | Classy Paragraphs configuration for a finer 24‑column grid. |

For example, for the standard grid:

```bash
drush en paragraphs_bootstrap_layouts_12_col -y
```

## Verify it worked

Go to **Structure → Paragraph types** (`/admin/structure/paragraphs_type`) and
confirm that **Bootstrap Row** and **Bootstrap Column** paragraph types are listed.
Then add a Paragraphs field that allows the Row type, build a row with a couple of
columns, and view the page on your Bootstrap‑compatible theme — the columns should
line up in the grid.
