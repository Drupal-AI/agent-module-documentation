# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Node** module (`node`).
- Core's **Taxonomy** module (`taxonomy`).

Drupal enables both dependencies automatically when you turn on Node by Term. There
are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_by_term -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_by_term -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_by_term -y
```

On enabling, the module shows a "Go to nodelist" message linking to the tool.

## Verify it worked

As **user 1**, visit **`/node-list`**. You should see the filter form with a
**Vocabulary** select; choosing a vocabulary should load its terms into the **Term**
select, and submitting should produce a results table. If other roles get an access
denied error, that's expected — see the access note in the
[overview](../index.md), since the gating permission is not declared for the
Permissions screen.
