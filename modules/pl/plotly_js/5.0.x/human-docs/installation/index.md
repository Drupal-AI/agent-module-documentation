# Installation

## Requirements

- **Drupal 11.3 or newer, or Drupal 12** (`core_version_requirement:
  ^11.3||^12`).
- No other Drupal module dependencies — the field type is self‑contained.

There are no third‑party Composer or PHP library requirements listed.

## Install with Composer

From the project root:

```bash
composer require drupal/plotly_js -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plotly_js -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plotly_js -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click
**Add field**. If **Plotly.js** appears in the list of available field types, the
module is installed and ready. Add the field, pick a graph type, and create a
piece of content to see the chart render.
