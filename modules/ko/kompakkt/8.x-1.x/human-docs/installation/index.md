# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

Kompakkt has **no module or PHP library dependencies** — it uses core's Field API.

## Install with Composer

From the project root:

```bash
composer require drupal/kompakkt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/kompakkt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en kompakkt -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Content types → *(any type)* →
Manage fields** (`/admin/structure/types`). Click **Add field** and confirm that
**Embed Kompakkt** appears in the field‑type list. If it does, the module is
installed — see the main [guide](../index.md#how-to-use-it) for adding the field
and embedding a model. There is nothing else to configure.
