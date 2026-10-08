# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The core **Project Browser** (`project_browser`) module, enabled.

There are no third‑party Composer or PHP library requirements, and no other
recommended modules.

## Install with Composer

From the project root:

```bash
composer require drupal/extra_project_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extra_project_browser -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extra_project_browser -y
```

No additional configuration is required — the **Extra recipes** source is enabled
automatically.

## Verify it worked

Visit the **Project Browser** page. The **Extra recipes** source should be active,
and any `extra_*` recipes present in your codebase should appear in the list, ready
to browse and apply. If none appear, confirm that you actually have recipe
directories whose names start with `extra_` in a location Project Browser scans.
