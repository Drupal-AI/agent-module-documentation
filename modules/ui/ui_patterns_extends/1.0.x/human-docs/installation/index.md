# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[UI Patterns](https://www.drupal.org/project/ui_patterns)** module
  (`ui_patterns`) — this is what defines patterns in the first place.
- The **[Token](https://www.drupal.org/project/token)** module (`token`), used by the
  setting types in this ecosystem.

## Install with Composer

From the project root:

```bash
composer require drupal/ui_patterns_extends -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in UI Patterns and Token
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ui_patterns_extends -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ui_patterns_extends -y
```

There are no submodules and nothing to configure. Once enabled, the `extends:` key
becomes available in your pattern definitions — see the
[overview](../index.md#how-to-use-it) for the syntax. Clear caches after editing
pattern YAML so the new definitions are rebuilt.
