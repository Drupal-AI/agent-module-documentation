# Installation

## Requirements

Phylotree Viewer needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **file field** to attach the formatter to (core's File module provides this).
- Several **external JavaScript/CSS libraries** — Phylotree.js, D3.js 3.5.17,
  jQuery, and Underscore.js — which you download and place manually. These are
  **not** installed by Composer; see "Set up the external libraries" in the
  [overview](../index.md).

There are no third‑party Composer library requirements for the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/phylotree_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phylotree_viewer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phylotree_viewer -y
```

## Verify it worked

The module installs the required JavaScript libraries separately from Composer,
so after enabling, follow the steps in the [overview](../index.md) to download and
place those library files, then open the **Phylotree Viewer Configurations** page
and click **Test Libraries**. When the libraries are detected, apply the
**Phylotree Viewer** formatter to a file field on a content type's **Manage
display** tab and view a node that has a tree file uploaded — the tree should
render interactively.
