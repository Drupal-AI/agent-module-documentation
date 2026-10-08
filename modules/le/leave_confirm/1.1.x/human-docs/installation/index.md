# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **modern browser with JavaScript enabled** (Chrome, Firefox, Safari, Edge) —
  the warning is delivered by the browser's `beforeunload` mechanism.
- For best results, a theme that renders forms in the standard way.

There are no other Drupal module dependencies and no third‑party Composer or PHP
libraries of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/leave_confirm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/leave_confirm -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leave_confirm -y
```

On installation the module automatically adds form points for common forms — user
forms, node forms, and webform forms — so it starts protecting the obvious cases
immediately.

## Verify it worked

Open a protected form (a node edit form, for example), make a change to a field,
then try to navigate away without saving. The browser should show its
"Leave site? Changes you made may not be saved" prompt. Then visit
**Configuration → User interface → Leave Confirm** to review and adjust which
forms are covered — see [Configuration](../configuration/index.md).
