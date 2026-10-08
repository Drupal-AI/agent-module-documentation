# Installation

## Requirements

SHS depends only on Drupal core:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — enabled automatically as a
  dependency, since SHS works on taxonomy term-reference fields.

There are no third-party Composer packages or PHP libraries to install. The
client-side widget is built on Backbone.js, which ships with Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/shs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shs -y
```

After enabling, there is nothing to configure globally. Go to a taxonomy
term-reference field's **Manage form display** and switch its widget to **Simple
hierarchical select** — see the [overview](../index.md#how-to-use-it) for the
step-by-step.

## Submodule — Chosen styling

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **SHS Chosen** | `shs_chosen` | Layers the Chosen jQuery plugin over the SHS level dropdowns, making each select searchable and styled. Adds a **Simple hierarchical select: Chosen** widget option. |

Enable it only if you want the Chosen styling:

```bash
drush en shs_chosen -y
```

It requires the base SHS module, which is already present once you have installed
it above.
