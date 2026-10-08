# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

The module lists no other module dependencies and no third-party Composer or PHP
libraries. It works through Drupal's standard Field, Field UI, and display
system, so make sure **Field UI** is enabled if you want to add fields and assign
widgets/formatters through the admin UI.

> **Version note:** this is an alpha release (2.0.0-alpha1). Test it on a
> non-production site before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/aframe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aframe -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aframe -y
```

Once enabled, the A-Frame field type, widget, and formatter are available when you
manage fields on a content type — see
[How to use it](../index.md#how-to-use-it) on the overview page.
