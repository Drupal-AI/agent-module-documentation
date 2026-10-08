# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Text** module (which provides the *Text (formatted, long, with
  summary)* field type) — part of a standard Drupal install.

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/text_summary_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/text_summary_options -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en text_summary_options -y
```

There is no configuration form to visit. Once enabled, the three summary options
appear on the edit form of any *Text (formatted, long, with summary)* field. See
the [overview](../index.md) for how to set them.
