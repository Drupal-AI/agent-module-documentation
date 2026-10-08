# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **UI Patterns** module (`ui_patterns`) — this module extends it, so it must
  be present.
- The **Token** module (`token`) — used by the token setting type.

Composer pulls the required modules in for you with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ui_patterns_settings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in UI Patterns and
Token and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ui_patterns_settings -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ui_patterns_settings -y
```

This also enables UI Patterns and Token if they are not already on.

## Submodules

UI Patterns Settings ships no submodules.

## Next steps

There is no configuration form. You use the module by declaring `settings` in your
patterns' YAML definitions — see [How to use it](../index.md#how-to-use-it) in the
overview.
