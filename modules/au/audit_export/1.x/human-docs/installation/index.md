# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Audit Export Core** submodule (`audit_export_core`) — the engine the other
  submodules depend on. It ships in this project.
- No third-party Composer libraries are required.

> The current release is a beta (**1.0.0-beta3**) — test it on a non-production
> environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/audit_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audit_export -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module together with the core engine and whichever tool/post
submodules you need:

```bash
drush en audit_export audit_export_core audit_export_tool -y
```

Add `audit_export_post` as well if you need what it provides. Once enabled,
restrict the audit/export capability to trusted administrators. See
[How to use it](../index.md#how-to-use-it).
