# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No modules outside Drupal core, and no third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/remove_meta_info -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remove_meta_info -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remove_meta_info -y
```

That's all — there is no configuration step.

## Verify it worked

View the page source of any front-end page (in most browsers, right-click → *View
page source*) and confirm the Drupal-generated `generator` meta tag is no longer
present in the `<head>`. You may need to clear Drupal's cache (`drush cr`) and
reload to see the change.
