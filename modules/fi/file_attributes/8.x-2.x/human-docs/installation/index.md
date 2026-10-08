# Installation

## Requirements

- **Drupal 9.3+ or 10** (`core_version_requirement: ^9.3 || ^10`). Drupal 11 is not
  declared for this release — check the project page for a newer version before using
  it on Drupal 11.
- No other modules are required (it builds on core's file/field support), and there
  are no third-party Composer or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/file_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_attributes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_attributes -y
```

## Verify it worked

Go to a content type that has a file field. On **Manage form display**, the **File
attributes** widget should be selectable for the field; on **Manage display**, the
**File attributes** formatter should be available. Set both, then edit a piece of
content, enter an attribute (for example `target="_blank"`), and confirm the rendered
download link carries it. See [the overview](../index.md#how-to-use-it) for details.
