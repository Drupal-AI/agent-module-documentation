# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Path Alias** module (`path_alias`), enabled automatically as a
  dependency.

Optional integrations (not required):

- **Commerce** (`drupal/commerce`) — to show the buttons on Commerce product pages.
- **Markdown** (`drupal/markdown`) — to render the module's README on its help page.

There are no other third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/share_everywhere -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/share_everywhere -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en share_everywhere -y
```

There are no submodules. After enabling, grant the **Administer share everywhere**
permission to the roles that should manage the buttons, then configure them on the
settings page — see [Configuration](../configuration/index.md).
