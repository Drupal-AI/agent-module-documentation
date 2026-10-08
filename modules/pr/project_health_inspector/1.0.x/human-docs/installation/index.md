# Installation

## Requirements

- **Drupal 10.3+, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).

There are no other module dependencies and no external libraries or APIs. Drush is
optional but recommended for command-line scans and Markdown export.

## Install with Composer

From the project root:

```bash
composer require drupal/project_health_inspector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/project_health_inspector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en project_health_inspector -y
```

## Verify it worked

After enabling, grant the **Access Project Health Inspector report** permission to
your user, then visit **Reports → Project Health Inspector**
(`/admin/reports/project-health-inspector`) and run a scan. You should see a list
of findings across your contrib/custom modules. See the
[main guide](../index.md#how-to-use-it) for the full workflow, permissions, and
Markdown export.
