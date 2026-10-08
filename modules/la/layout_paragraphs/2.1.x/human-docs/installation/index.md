# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs` `^1.6`) — Composer installs it.
- Core's **Layout Discovery** module (`layout_discovery`), which supplies the layouts —
  enabled automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs along with
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/layout_paragraphs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_paragraphs -y
```

Drupal enables Paragraphs and Layout Discovery automatically as dependencies. Next,
head to [Configuration](../configuration/index.md) to wire up the widget, formatter
and section behavior — the builder doesn't appear until you do.

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Layout Paragraphs Library** | `layout_paragraphs_library` | Integrates the Paragraphs Library — "Promote to library" makes a component reusable across content, and "Unlink from library" turns a referenced item back into an editable local copy. |
| **Layout Paragraphs Permissions** | `layout_paragraphs_permissions` | Adds granular permissions so you can grant only certain roles the ability to reorder or duplicate components, or gate access to the layout plugin configuration form. |

For example:

```bash
drush en layout_paragraphs_permissions -y
```

Each submodule requires the base Layout Paragraphs module, which is already present
once you've installed it above.
