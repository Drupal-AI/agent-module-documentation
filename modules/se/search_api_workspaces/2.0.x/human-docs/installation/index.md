# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Search API** module (`search_api`), **version 8.x-1.14 or newer**.
- Core's **Workspaces** module (`workspaces`).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_workspaces -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_workspaces -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_workspaces -y
```

Drupal enables Search API and Workspaces as dependencies at the same time if they
are not already on.

## Verify it worked

Edit a Search API index (**Configuration → Search and metadata → Search API**).
You should now see the workspace-aware content **datasource** available to select.
Switch to it and re-index — after that, indexed items are associated with their
workspace and the **Search API Workspace** filter becomes available in your Search
API Views.
