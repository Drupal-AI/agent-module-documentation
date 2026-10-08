# Installation

## Requirements

Paragraphs runs on Drupal 10.3+ or 11. It depends on one other contrib module and one
core module, which are pulled in for you:

- **Entity Reference Revisions** (`entity_reference_revisions`, `~1.3`) — provides the
  revisionable reference field that stores paragraphs on the host entity. Composer
  installs it automatically.
- **File** (`file`) — a Drupal core module, enabled as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update
`entity_reference_revisions` as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs -y
```

This also enables `entity_reference_revisions` and core `file`. Once enabled, the
**Paragraphs types** screen appears under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## Submodules — enable only what you need

Paragraphs ships several optional submodules. Enable them individually:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Paragraphs Library** | `paragraphs_library` | Lets an editor save a single authored paragraph once and reuse it across many pages. Entity Browser is recommended alongside it for a nicer picker. |
| **Paragraphs Type Permissions** | `paragraphs_type_permissions` | Adds per‑type create/edit/delete permissions so you can grant or deny access to individual Paragraphs types by role. |
| **Paragraphs Demo** | `paragraphs_demo` | Example Paragraphs types and content to explore the module. Handy for learning, not for production. |

For example, to enable per‑type permissions:

```bash
drush en paragraphs_type_permissions -y
```

## Verify it worked

Log in as an administrator and go to `/admin/structure/paragraphs_type`. If the
**Paragraphs types** list loads with an **+ Add paragraph type** button, the module is
installed correctly. Next, review the [Configuration](../configuration/index.md) page,
then [create your first Paragraphs type](../creating-a-paragraph-type/index.md).
