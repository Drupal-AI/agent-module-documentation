# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No required contrib module dependencies. The optional
  [Markdown](https://www.drupal.org/project/markdown) module is used only to render
  this module's own README on its help page — it is not needed for the formatter to
  work.

There are no third-party Composer or PHP library requirements. This module is
covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/details_summary_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/details_summary_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en details_summary_field_formatter -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage display**, and for a text
field open its **Format** dropdown. You should now see **Details with Summary** as
an option. See the [main guide](../index.md) for the formatter's settings.

> **Note:** Clear the Drupal cache after saving the formatter's configuration if a
> change doesn't appear right away.
