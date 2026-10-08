# Installation

## Requirements

Font Awesome Formatter for Int List is deliberately small. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Font Awesome (or another class-based icon font) loaded by your theme** — the
  module renders the icon markup but does not bundle the icon library. If no icon
  font is present you will see blank space instead of icons.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fa_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fa_formatter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fa_formatter -y
```

## Verify it worked

Add or open an integer / list (integer) field on any content type, go to that
bundle's **Manage display**, and confirm the Font Awesome formatter now appears in
the field's list of format options. Set a test value on a node and check that it
renders as the expected number of icons. If you see empty gaps instead of icons,
your theme is not loading Font Awesome yet — that is the most common setup issue.
