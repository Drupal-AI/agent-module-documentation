# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules and no third‑party libraries are required.

The module is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/preview_wrapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/preview_wrapper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en preview_wrapper -y
```

## Verify it worked

After enabling, grant the **Manage preview wrappers** permission to a site‑builder
role under **People → Permissions**. Then preview a piece of content using the
normal **Preview** button — the preview should render inside its surrounding regions
and layout rather than as a bare, out‑of‑context render.
