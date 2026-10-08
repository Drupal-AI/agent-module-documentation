# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- The **Declarative Form Ajax** (`declarative_form_ajax`) module — Action Link
  depends on it. Composer pulls it in automatically when you require Action Link.

## Install with Composer

From the project root:

```bash
composer require drupal/action_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
Declarative Form Ajax and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/action_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en action_link -y
```

This is a beta release (1.0.0-beta1), so test in a non-production environment
first.

## Submodules — enable only what you need

Action Link ships five optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity links** | `action_link_entity_links` | Action links tied to entity operations. |
| **Field links** | `action_link_field` | Action links backed by a field. |
| **Formatter links** | `action_link_formatter_links` | Action links rendered through a field formatter. |
| **Workflow** | `action_link_workflow` | Links that drive content-moderation / workflow transitions. |
| **Proof of concept** | `action_link_poc` | A working demo of the framework — enable it to explore how action links behave, disable it once you have your own. |

For example, to add workflow-transition links:

```bash
drush en action_link_workflow -y
```

Each submodule requires the base Action Link module, which is already present
once you have installed it above.
