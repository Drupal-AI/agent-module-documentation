# Installation

## Requirements

Node Title Help Text is about as lightweight as a module gets. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** module (part of a standard Drupal install) — it works on node
  content types.

There are no third‑party Composer packages, no PHP library requirements, and no
other module dependencies. The **Inline Entity Form** module is supported if you
have it, but it is entirely optional.

## Install with Composer

From the project root:

```bash
composer require drupal/node_title_help_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_title_help_text -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_title_help_text -y
```

That is all it takes. There is no configuration form to visit — enabling the module
simply adds a **Title field help text** box to every content type's edit form. See
the [overview](../index.md#how-to-use-it) for where to fill it in.
