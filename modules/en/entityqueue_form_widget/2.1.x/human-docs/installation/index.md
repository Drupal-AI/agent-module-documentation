# Installation

## Requirements

- **Drupal 11.4+ or 12** (`core_version_requirement: ^11.4 || ^12`).
- The **Entityqueue** module (`drupal/entityqueue: ~1.1`) installed and enabled —
  this add-on has no purpose without it, and Drupal enables it as a dependency.

There are no additional third-party Composer packages or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entityqueue_form_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Entityqueue if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entityqueue_form_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entityqueue_form_widget -y
```

Enabling Entityqueue pulls in its own dependencies. Once both modules are on,
there is nothing to configure — create a node-targeting entityqueue (if you don't
have one already) and the sidebar panel appears on that content type's edit form.
See [How to use it](../index.md#how-to-use-it).

## Permissions

This module defines no permissions. Which queue checkboxes an editor sees is
governed by **Entityqueue's** permissions — the per-queue *Update this queue*
permission, or the site-wide *Manipulate all entityqueues* permission. Grant
those at **People → Permissions**.

This module ships no submodules.
