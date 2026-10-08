# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other required Drupal module dependencies, and no third‑party Composer or PHP
  library requirements. The Paragraphs example submodule naturally expects the
  [Paragraphs](https://www.drupal.org/project/paragraphs) module if you enable it.

## Install with Composer

From the project root:

```bash
composer require drupal/pluggable_entity_view_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pluggable_entity_view_builder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pluggable_entity_view_builder -y
```

## Submodules — optional examples

PEVB ships two example submodules. They are learning aids, not something you keep
enabled in production:

| Submodule | Machine name | What it demonstrates |
|-----------|--------------|----------------------|
| **Pluggable Entity View Builder Example** | `pluggable_entity_view_builder_example` | Overrides the Article node's rendering with a PHP view‑builder class so you can see the approach end to end. |
| **Pluggable Entity View Builder Paragraphs Example** | `pluggable_entity_view_builder_paragraphs_example` | Adds a Paragraphs field to Article and renders the Paragraphs from classes — an alternative to Layout Builder for composable pages. |

Enable one with, for example:

```bash
drush en pluggable_entity_view_builder_example -y
```

After enabling an example, clear caches (`drush cr`) so the new settings take
effect.

## Verify it worked

With the base module enabled, PEVB is available for your own view‑builder classes.
The simplest confirmation is to enable the example submodule, clear caches, turn
on its override setting, and reload an Article node — its markup should now come
from the example class rather than core's default templates.
