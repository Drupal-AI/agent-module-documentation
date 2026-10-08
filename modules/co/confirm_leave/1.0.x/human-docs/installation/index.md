# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules, PHP extensions, or third‑party libraries are required.

Note that the current release is a **beta** (`8.x-1.0-beta6`). Test it on a
non‑production environment before relying on it for a live editorial team.

## Install with Composer

From the project root:

```bash
composer require drupal/confirm_leave -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/confirm_leave -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en confirm_leave -y
```

That is all — there is no configuration step.

## Verify it worked

Open a content edit form, type something into a field, then try to close the tab or
click a link that leaves the page. Your browser should show its generic
"changes you made may not be saved" confirmation. Save the form and the same
navigation should no longer prompt.
