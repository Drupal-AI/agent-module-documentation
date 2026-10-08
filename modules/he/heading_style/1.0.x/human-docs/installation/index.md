# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies. To get the most out of it you'll want a CSS file
  (typically from your theme) that defines the heading classes you want to offer,
  since the module reads its selectable classes from CSS.

## Install with Composer

From the project root:

```bash
composer require drupal/heading_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/heading_style -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en heading_style -y
```

## Verify it worked

Log in as an administrator and open the Heading Style settings form under
**Configuration** (see [Configuration](../configuration/index.md)). If the form
lists heading levels (h1–h6) with class options to choose from, the module is
installed and ready.
