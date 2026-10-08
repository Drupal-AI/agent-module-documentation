# Installation

## Requirements

Content Import needs:

- **Drupal 8.7.7 or newer, through 11**
  (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) — its only dependency, and part of a standard
  Drupal install.
- **Write access to `sites/default/files/`** — the module writes its import log and
  sample CSV files there, so the directory must be writable or those steps fail.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/contentimport -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contentimport -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contentimport -y
```

The module ships no permission of its own — access to the import form is controlled
by the core **Administer site configuration** permission.

## Submodules

This module ships no submodules — the base module is everything.

## Verify it worked

Go to **Configuration → Content authoring → Content Import**
(`/admin/config/content/contentimport`). You should see a form to pick a content
type, choose an import type, and upload a CSV. See
[Configuration](../configuration/index.md) for how to run an import.
