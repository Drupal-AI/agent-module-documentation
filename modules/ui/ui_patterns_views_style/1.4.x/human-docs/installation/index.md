# Installation

## Requirements

UI Patterns Views Style needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), enabled.
- **UI Patterns** (`ui_patterns`) — and specifically the **1.x** API, since this 1.4.x
  branch targets UI Patterns 1.x. You also need at least one pattern defined (by a theme
  or module) for the style to be useful.
- Optionally, **UI Patterns Settings** (`ui_patterns_settings`) — only if you want to set
  per-pattern settings directly on a View.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ui_patterns_views_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed. If UI Patterns is not already present, add it too (`composer require
drupal/ui_patterns`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ui_patterns_views_style -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ui_patterns_views_style -y
```

Drupal enables Views and UI Patterns as dependencies at the same time. Once enabled, the
**Pattern** style becomes available in the *Format* setting of any View display — see the
[overview](../index.md#how-to-use-it) for how to apply it.

There are no submodules.
