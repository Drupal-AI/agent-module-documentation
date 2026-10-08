# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (enabled by default on most sites) — the filter is a
  Views plugin.
- **Pathauto** (`drupal/pathauto`) — a hard dependency. The module uses
  Pathauto's alias cleaner to match term names, so it must be installed and
  enabled. Composer pulls it in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/views_taxonomy_term_name_depth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Pathauto and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_taxonomy_term_name_depth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_taxonomy_term_name_depth -y
```

Drupal enables Pathauto at the same time if it isn't already on.

## Verify it worked

There's no settings page to check. Instead, edit a view whose base is
**Content**, open **Advanced → Contextual filters → Add**, and confirm that
**"Has taxonomy term NAME (with depth)"** appears in the *Content* category. If
it does, the module is active. See [How to use it](../index.md#how-to-use-it) for
the next steps.
