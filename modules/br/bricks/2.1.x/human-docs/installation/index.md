# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Entity Reference**, **Field UI** and **Layout Discovery** are the
  practical prerequisites — Bricks builds on entity reference, display modes and
  the Layout API. Enabling Field UI is what gives you the *Manage fields / form
  display / display* screens you'll use to set it up.
- Note that the module declares a Composer requirement on the **Bartik** theme
  (`drupal/bartik:^1.0`); Composer will pull it into your codebase when you
  require Bricks, though you don't have to use it.

There are no other module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/bricks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bricks -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bricks -y
```

Enabling the base module gives you the `bricks` field type, its widgets and the
Bricks formatter. The next step is to add a Bricks field to a bundle — see
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

Bricks ships seven optional submodules. Enable them individually with `drush en`.
The three `bricks_default*` ones are demonstration setups (handy for seeing a
working example), while the rest add editing variants:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Bricks Default** | `bricks_default` | A backward-compatibility shim; enable only if something expects it. |
| **Bricks Default Blocks** | `bricks_default_blocks` | A ready-made demo built from Bricks plus custom blocks. |
| **Bricks Default Paragraphs** | `bricks_default_paragraphs` | A ready-made demo built from Bricks plus paragraphs. |
| **Bricks Dynamic** | `bricks_dynamic` | Reference several different entity types in one Bricks field. |
| **Bricks Inline** | `bricks_inline` | An Inline Entity Form widget for editing bricks in place. |
| **Bricks Paragraphs** | `bricks_paragraphs` | A paragraphs-widget-based Bricks widget. |
| **Bricks Revisions** | `bricks_revisions` | Revisioned bricks via `entity_reference_revisions`. |

For example, to add the Inline Entity Form editing experience:

```bash
drush en bricks_inline -y
```

Each submodule requires the base Bricks module, which is already present once you
have installed it above.
