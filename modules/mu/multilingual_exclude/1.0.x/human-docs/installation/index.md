# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **multilingual site** — the module is only meaningful when you have multiple
  languages and language negotiation configured (core Language and, typically,
  Content/Configuration Translation).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/multilingual_exclude -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multilingual_exclude -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multilingual_exclude -y
```

## Verify it worked

Open the module's settings form (its *Configure* link on the **Extend** page, route
`multilingual_exclude.settings`). If the form loads and lets you add a route and
choose a theme, the module is installed — continue with
[Configuration](../configuration/index.md).
