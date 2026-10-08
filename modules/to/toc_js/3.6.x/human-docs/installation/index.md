# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** (`node`) and **Block** (`block`) modules enabled — these are
  hard dependencies and Drupal enables them automatically. (Both are on in a
  standard install.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/toc_js -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/toc_js -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en toc_js -y
```

## Grant the permission

The per-content-type **Table of contents** settings section is available to users
with the **Administer Toc.js** permission (or core's *Administer nodes*). Grant
*Administer Toc.js* under **People → Permissions**, or:

```bash
drush role:perm:add content_editor 'administer toc_js'
```

Placing and configuring the Toc.js block uses core's *Administer blocks*
permission.

## Submodules — enable only what you need

Toc.js ships two optional submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Toc.js Filter** | `toc_js_filter` | A text-format filter that lets you embed a table of contents directly inside a field's body text. Enable it and add the filter to a text format. |
| **Toc.js per node** | `toc_js_per_node` | A per-node toggle (and a per-node block) so editors can turn the TOC on or off for individual nodes. Adds its own *Administer Toc.js per node* permission. |

Enable them individually with `drush en`, for example:

```bash
drush en toc_js_per_node -y
```

## Verify it worked

Enable the TOC on a content type (or place the block), view a page with several
headings, and you should see a generated, clickable table of contents. If it
doesn't appear, double-check that you placed the **Toc** field on the content
type's Manage display, or that the block is in a visible region.
