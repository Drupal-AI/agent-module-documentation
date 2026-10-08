# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- To configure it you will want core's **Field UI** enabled, since the setting
  lives on the field display screens. The module itself declares no module
  dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_formatter_pattern -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_formatter_pattern -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_formatter_pattern -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage form display**, click
the settings (gear) icon for a text field, and confirm the pattern option
appears. Enter a pattern, click **Update**, and **Save** — then confirm the
attribute shows up in the rendered field markup.
