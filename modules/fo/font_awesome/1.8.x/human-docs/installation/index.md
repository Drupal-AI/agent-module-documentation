# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`lp_fontawesome`** module (`^5 || ^6`) — a required dependency that
  actually provides the Font Awesome library assets (built on Libraries
  Provider). Composer pulls it in automatically. Minimum Font Awesome version is
  5.8.0.
- No other module dependencies, and no third-party PHP libraries beyond what
  `lp_fontawesome` manages.

## Install with Composer

From the project root:

```bash
composer require drupal/font_awesome -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
`lp_fontawesome` library module and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/font_awesome -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en font_awesome -y
```

Drupal enables the required `lp_fontawesome` module automatically as a
dependency. This module ships no submodules of its own.

After enabling, review the Font Awesome library settings provided by
`lp_fontawesome` (CDN vs local, version, minification), then set up an icon field
on a content type as described in
[How to use it](../index.md#how-to-use-it). This module itself has no settings
page.
