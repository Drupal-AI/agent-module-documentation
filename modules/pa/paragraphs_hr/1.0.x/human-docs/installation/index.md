# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The **Paragraphs** module — this add-on provides a paragraph type, so you need
  Paragraphs enabled and a Paragraphs field to place the divider into.

There are no third-party Composer or PHP library requirements. Remember that the
CSS that styles the thin/thick dividers must come from your theme.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_hr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_hr -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_hr -y
```

## Verify it worked

Edit any content that has a Paragraphs field and click to add a paragraph — a
**horizontal rule** type should now be offered. Add one, save, and you should see
a divider on the rendered page. If the thin/thick variants look identical, that's
your cue to add the `hr--thin` / `hr--thick` styles to your theme's CSS.
