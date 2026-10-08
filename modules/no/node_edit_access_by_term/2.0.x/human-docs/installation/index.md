# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Taxonomy** and **Node** modules (standard on any Drupal site) — the module
  works by adding an allow‑list field to taxonomy terms and checking it on node edit
  forms.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_edit_access_by_term -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_edit_access_by_term -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_edit_access_by_term -y
```

## Verify it worked

Edit any taxonomy term (**Structure → Taxonomy → *(vocabulary)* → *(term)* →
Edit**). You should see a new field for the users that have edit access to nodes
tagged with that term. See [Configuration](../configuration/index.md) for how to use
it.
