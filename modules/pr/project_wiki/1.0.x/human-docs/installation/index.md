# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Help** module.
- The **ListJS** module and its **List.js** JavaScript library (used for the
  searchable/filterable list page).
- The **League CommonMark** PHP library (for Markdown rendering, used by the
  Markdown content submodule).

## Install with Composer

From the project root, install the module:

```bash
composer require drupal/project_wiki -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in dependencies such
as League CommonMark and update any shared packages as needed.

You also need the **List.js** front-end library, which is a Bower asset:

```bash
composer require bower-asset/listjs
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/project_wiki -W`,
> `ddev composer require bower-asset/listjs`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en project_wiki -y
```

## Submodules — you need at least one to author content

The base module provides the list page and permissions but **cannot create or edit
wiki content by itself**. Enable a content submodule:

| Submodule | What it adds |
|-----------|--------------|
| **Project Wiki Entity Content** | Create and manage wiki entries as content entities via the UI, with manageable fields and displays. |
| **Project Wiki Markdown Content** | Serve wiki content from Markdown files (optionally shipped by your own submodule, updatable remotely). Adds a *Markdown Content Settings* page. |
| **Project Wiki Markdown Content Example** | An example that documents how to build your own Markdown content submodule. |

Enable the one(s) you need, for example:

```bash
drush en project_wiki_entity_content -y
```

## Verify it worked

Open the **Project Wiki list page** from the Admin Toolbar — it should load and be
searchable. Then confirm that, with your chosen submodule enabled, you can create
an entry (via **Content → Project Wiki Entity**) or that Markdown content appears.
See the [main guide](../index.md#how-to-use-it) for the full workflow.
