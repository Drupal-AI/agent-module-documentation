# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No modules outside Drupal core, and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/input_pattern -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/input_pattern -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en input_pattern -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage form display**, open a
field's widget settings, and confirm you can now set the additional HTML
attributes (such as `pattern`, or a separator and step for numeric fields).
There is no separate configuration page — everything is set on the field itself,
as described in the [overview](../index.md).
