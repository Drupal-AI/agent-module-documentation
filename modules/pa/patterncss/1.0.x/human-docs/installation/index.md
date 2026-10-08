# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- No module dependencies.
- **No library download needed** — the Pattern.css library is already included with
  the module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/patterncss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/patterncss -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en patterncss -y
```

That's all — the Pattern.css classes are now available for use in your themes and
modules.

## Verify it worked

Add a Pattern.css class to an element in a theme template (for example a `div` that
should show a dotted background), clear caches, and view the page. The background
pattern should appear. Consult the
[Pattern.css documentation](https://bansal.io/pattern-css) for the available class
names.
