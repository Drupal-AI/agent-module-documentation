# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Form Decorator** module
  ([`form_decorator`](https://www.drupal.org/project/form_decorator)) — the only
  dependency. It is a separate contrib project, so Composer will pull it in for
  you when you require Path tools with the `-W` flag below.

There are no other third‑party Composer or PHP library requirements.

> **Heads up:** this project does not have official security‑advisory coverage.
> Weigh that before relying on it on a high‑stakes production site.

## Install with Composer

From the project root:

```bash
composer require drupal/path_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Form Decorator and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/path_tools -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en path_tools -y
```

Drupal will enable Form Decorator at the same time if it isn't already on.

## Verify it worked

Confirm the module is enabled — for example with `drush pm:list --status=enabled |
grep path_tools`, or on the **Extend** page (`/admin/modules`). Then, on a
taxonomy term page, check that the breadcrumb reflects the term's path.
