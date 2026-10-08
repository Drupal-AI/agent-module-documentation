# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A text or string field to format — the formatter applies to `string_long`,
  `text_long`, `text` and `text_with_summary` fields.
- **No third-party library** is required — highlighting is done with PHP's built-in
  `highlight_string()` function, so there is no GeSHi or similar dependency to
  install. No dependent Drupal modules, PHP extensions or external Composer packages
  are listed.

## Install with Composer

From the project root:

```bash
composer require drupal/syntax_highlighting_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/syntax_highlighting_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en syntax_highlighting_field_formatter -y
```

## Verify it worked

Go to a **Manage display** screen for an entity that has a text or string field
(for example a content type's display settings). The field's **Format** dropdown
should now include *Syntax Highlighting Field Formatter*. Select it, save, and view
an entity whose field holds a code snippet — it should render as highlighted source
code.
