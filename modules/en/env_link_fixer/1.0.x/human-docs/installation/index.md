# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib modules and no PHP or Composer libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/env_link_fixer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/env_link_fixer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en env_link_fixer -y
```

## Verify it worked

Enable the text filter on a text format and/or set the widget and formatter on a
link field (see [How to use it](../index.md#how-to-use-it)). Save a link with an
absolute production URL on a non‑production copy — it should be rewritten to point
at the current environment. Remember to set
`$settings['env_link_fixer_disabled'] = TRUE;` on production so the rewriting is
skipped there.
