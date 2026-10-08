# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9||^9||^10||^11`).
- Core's **Node** module (`node`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_title_ps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_title_ps -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_title_ps -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Taxonomy Term Name Prefix** | `taxonomy_term_title_ps` | Extends the prefix/suffix behavior to **taxonomy term** titles. Enable it only if you need to decorate term titles as well as node titles. |

Enable the submodule the same way when you want it:

```bash
drush en taxonomy_term_title_ps -y
```

## Verify it worked

Edit a content type at **Structure → Content types** and set a prefix or suffix, then
save. View a node of that type — its displayed title should now include the text you
entered. See the [overview](../index.md) for the step‑by‑step.
