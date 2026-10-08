# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled.
- The contrib **Token** module (`drupal/token` `^1.9`) — Composer pulls this in
  automatically. Token powers the "browse available tokens" helper in the filter
  form.

## Install with Composer

From the project root:

```bash
composer require drupal/views_argument_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies — including the Token module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_argument_token -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_argument_token -y
```

This also enables Views and Token if they aren't already on. Once enabled, the
**Token** default‑value type appears on any view's contextual filter — see the
[main guide](../index.md#how-to-use-it) for how to use it. There's no
configuration form and no permissions to grant.

This module ships no submodules.
