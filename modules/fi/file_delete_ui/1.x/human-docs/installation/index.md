# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **File** module (`file`) enabled — Drupal enables it automatically as a
  dependency (it is on by default on most installs).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_delete_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_delete_ui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_delete_ui -y
```

Enabling the module runs an install step that adds an Operations field to the core
Files view, so the **Delete** link appears at `/admin/content/files` immediately.
Note that uninstalling the module later does not automatically remove that view
field.

## After enabling

There is no configuration form. The one thing to do is grant the **Delete any
file** permission to the appropriate roles on **People → Permissions** — see [How
to use it](../index.md#how-to-use-it) in the overview.

## Submodules

File delete ships no submodules.
