# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No third‑party Composer packages, PHP libraries, or contrib module
  dependencies.

Note this project is **not covered by the security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_display_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_display_processor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_display_processor -y
```

Note that this release line is a **beta** (`1.0.0-beta2`); test it before relying on
it in production.

## Verify it worked

Go to a view mode's **Manage display** screen — for example
`/admin/structure/types/manage/page/display/teaser` (assuming a *page* content type
with a *teaser* view mode). Scroll to the bottom of the form: you should now be able
to choose and configure an **entity display processor** plugin for that view mode.
