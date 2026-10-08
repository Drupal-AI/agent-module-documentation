# Installation

## Requirements

Manage Display has no third-party libraries and no module dependencies beyond Drupal
core. It needs:

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).

It works with the entity types it targets out of the box (node, user, taxonomy term,
comment, and aggregator feeds/items) — no extra modules are required, though the
relevant core modules (Comment, Taxonomy, etc.) obviously need to be on for those
fields to appear.

## Install with Composer

From the project root:

```bash
composer require drupal/manage_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/manage_display -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en manage_display -y
```

There's no settings form — enabling the module *is* the setup. As soon as it's on, the
base fields (title, author, date, and so on) appear as rows on your **Manage display**
screens, ready to be reordered, formatted, and hidden. Head to the
[overview's "How to use it"](../index.md#how-to-use-it) for the workflow.

## About the submodule

The package includes a submodule called **`manage_display_fix_title`**, but it is
**obsolete** — it's no longer needed and can't be installed on Drupal 11. You don't
need to enable it; on upgrade the module even uninstalls it automatically. Just enable
the main `manage_display` module and ignore the submodule.

## Verify it worked

Open **Structure → Content types → Article → Manage display**. You should now see a
**Title** row (and, in the *Disabled* region, **Authored by** and **Authored on**
rows) that weren't there before. Click the Title cog and you'll find the new **Tag**
option for choosing its heading element.
