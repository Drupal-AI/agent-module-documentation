# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies and no third‑party PHP or library requirements. (If you
  want to expose the breadcrumb over an API, you will typically also have core's
  **JSON:API** module enabled, but Computed Breadcrumbs does not require it.)

## Install with Composer

From the project root:

```bash
composer require drupal/computed_breadcrumbs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/computed_breadcrumbs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en computed_breadcrumbs -y
```

## Verify it worked

The module adds a `breadcrumbs` computed property to nodes. Confirm it in code
(`$node->get('breadcrumbs')->getValue();`) or, if JSON:API is enabled, fetch a
node over JSON:API and check that the breadcrumb data is present in the response.
Remember the per-request cost and context caveats noted in the
[overview](../index.md) before using it on high-volume responses.
