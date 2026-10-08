# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Field** and **Field UI** modules (standard on most sites) so you can
  attach and configure Number/Decimal/Float fields.
- The widget's live masking relies on the **AutoNumeric.js** JavaScript library.
  After enabling the module, check its README/status report for how it expects the
  library to be provided on your build.

There are no Drupal module dependencies, and the module is covered by Drupal's
security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/formatted_number_input -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/formatted_number_input -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en formatted_number_input -y
```

## Verify it worked

There is no admin settings page. To confirm the module is available, edit a
content type that has a Number, Decimal, or Float field, open its **Manage form
display**, and check that **Formatted Number Input** appears as a widget option.
Then set the widget, add some content, and confirm the value formats live as you
type. See [the overview page](../index.md) for the full setup walkthrough.
