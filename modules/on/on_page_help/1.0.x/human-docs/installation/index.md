# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- These modules, which Drupal enables as dependencies:
  - core **Link** (`link`),
  - core **Node** (`node`),
  - core **Options** (`options`),
  - **Prepopulate** (`prepopulate`) — used to pre‑fill the route (and node type) on
    the "add help" link.

There are no third‑party Composer libraries or special PHP extensions beyond these.

## Install with Composer

From the project root:

```bash
composer require drupal/on_page_help -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Prepopulate module if it isn't present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/on_page_help -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en on_page_help -y
```

Enabling it also turns on its dependencies and creates the default **Route On-Page
Help** type.

## Verify it worked

Go to **Structure → On-Page Help** (`/admin/structure/on_page_help`) and confirm the
default type is present, then place an **On-Page Help block** at **Structure → Block
layout** and add a help item from a page's contextual "add" link. Full setup is in the
[guide overview](../index.md).
