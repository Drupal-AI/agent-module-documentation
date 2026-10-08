# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Paragraphs** (`paragraphs`) and **Entity Reference Revisions**
  (`entity_reference_revisions`) — Composer installs these as dependencies.
- PHP 8.1+ (the module uses modern strict typing).

## Install with Composer

Installing with Composer pulls in Paragraphs and Entity Reference Revisions if they
are not already present:

```bash
composer require drupal/pb_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pb_import -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pb_import -y
```

## Submodules — enable what you need

PB Import ships two submodules that provide the actual import workflows. Enable the
ones you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **PB Import Node** | `pb_import_node` | The bulk **node** import workflow (Content → PB Import → Import Nodes). |
| **PB Import Paragraphs** | `pb_import_para` | The hierarchical **paragraph** import workflow (Content → PB Import → Import Paragraphs). |

For example, to enable both:

```bash
drush en pb_import_node pb_import_para -y
```

Each submodule requires the base PB Import module, which is already present once you
have installed it above.

## Verify it worked

Log in as an administrator and open **Content → PB Import**. You should see the
Paragraphs List, Register Uploaded Files, and (for whichever submodules you
enabled) the Import Nodes and Import Paragraphs screens. Try a small test CSV first
and review the row-level import log before running a large migration.
