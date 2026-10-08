# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- Core **File** module (`file`).
- The contrib modules **Select2** (`drupal/select2 ^2.0`) and **Select or Other**
  (`drupal/select_or_other ^4.2.0`) — these power the dropdown widgets. Composer
  installs both automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/json_form_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Select2 and Select
or Other and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/json_form_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_form_widget -y
```

Drupal enables the Select2, Select or Other, and File dependencies at the same time.

## Enable the basic submodule (recommended)

The base module is a framework and needs a widget to supply the schema. Unless you
are writing your own widget, enable the bundled **basic** submodule, which lets you
paste a schema straight into a field's form-display settings:

```bash
drush en json_form_widget_basic -y
```

## After enabling

There is no settings page to visit. Add a field that can store the JSON output
(`json`, `json_native`, `text_long`, or `string_long`), then set its widget to the
JSON Form Widget under **Manage form display**. See the
[overview](../index.md#how-to-use-it) for the step-by-step.
