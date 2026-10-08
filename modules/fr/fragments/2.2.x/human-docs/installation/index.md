# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

The module has no other module dependencies and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fragments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fragments -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fragments -y
```

## Recommended companion modules

Fragments works on its own, but a few modules make it noticeably nicer to use:

| Module | Why |
|--------|-----|
| **Views Bulk Operations** | Installs an alternative, Views‑based admin screen for fragments with filtering, sorting, and bulk operations. |
| **Inline Entity Form** | Provides an entity‑reference widget that lets editors create a new fragment inline — right in the node form where you reference it — instead of on a separate page. |
| **Automatic Entity Label** | Helps set things up so editors usually only fill in a display title, while still being able to override the administrative label used to tell two similar fragments apart. |

Install any of these the same way, for example:

```bash
composer require drupal/inline_entity_form -W
drush en inline_entity_form -y
```

## Verify it worked

Go to **Structure → Fragment types** (`/admin/structure/fragment_type`). You should
see the fragment types administration page, ready for you to add your first fragment
type as described in [Configuration](../configuration/index.md).
