# Installation

## Requirements

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules, PHP libraries or third‑party dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/split_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/split_preview -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en split_preview -y
```

## Turn on preview for a content type

Split Preview only appears where Drupal's own preview is enabled:

1. Go to **Structure → Content types** and edit a content type.
2. Set **Preview before submitting** to *Optional* or *Required*.
3. Save.

## Verify it worked

Add or edit a node of that content type. The old *Preview* button now reads
**Live Preview** — click it and the rendered node should load in an iframe next to
the form, with mobile / tablet / desktop width toggles.
