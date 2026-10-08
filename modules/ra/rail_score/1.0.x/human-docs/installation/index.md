# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or higher** (8.1+ recommended).
- Core's **Field** (`field`), **Node** (`node`), and **User** (`user`) modules —
  required dependencies, normally already present.
- A **RAIL Score API key** — get one at responsibleailabs.ai.
- *(Optional)* the Drupal **AI** module, if you want automatic scoring of AI provider
  responses and generated field values.

## Install with Composer

From the project root:

```bash
composer require drupal/rail_score -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rail_score -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rail_score -y
```

## Verify it worked

Log in as an administrator and visit **Reports → RAIL Score**
(`/admin/reports/rail-score`). If the dashboard loads, the module is installed. Then
provide your RAIL Score API key and choose your evaluation options as described in
"Setting it up" on the [overview page](../index.md).
