# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Single Content Sync** module (`single_content_sync`) — Flexible
  descriptions depends on it, and Composer pulls it in automatically with the
  command below.
- The 2.0 inline editing feature uses the **HTMX** library; translation features
  build on core's multilingual modules if you localise help text.

## Install with Composer

From the project root:

```bash
composer require drupal/flexible_descriptions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
`single_content_sync` dependency (and any shared libraries) alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flexible_descriptions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flexible_descriptions -y
```

## Submodules

Flexible descriptions ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Flexible descriptions sync** | `flexible_descriptions_sync` | Synchronisation support for moving descriptions between environments, complementing the built-in YAML import/export. Enable it only if you need that workflow. |

Enable it the same way when you want it:

```bash
drush en flexible_descriptions_sync -y
```

## Verify it worked

Log in as an administrator and open the Flexible descriptions settings/management
area (see [Configuration](../configuration/index.md)). If the central screen lists
your entity types and bundles and lets you edit a field's description, the module
is working. The project's `README.md` also has post-installation notes worth a
quick read.
