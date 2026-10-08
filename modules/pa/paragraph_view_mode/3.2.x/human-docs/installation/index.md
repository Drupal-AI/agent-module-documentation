# Installation

## Requirements

Paragraph View Mode has no third-party libraries. It builds on the Paragraphs
ecosystem:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **[Paragraphs](https://www.drupal.org/project/paragraphs)** module
  (`paragraphs`, version 1.x) — a hard dependency, pulled in by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_view_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in the Paragraphs module if it isn't
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_view_mode -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_view_mode -y
```

This enables Paragraphs as well if needed. There are no submodules and no central
settings form.

Enabling the module doesn't change anything on its own — you turn the feature on
per paragraph type. Continue to [Configuration](../configuration/index.md).

## Verify it worked

Edit any paragraph type at **Structure → Paragraphs types → *(type)* → Edit**. Near
the bottom you should now see a checkbox: **Enable Paragraph view mode field on this
paragraph type**.
