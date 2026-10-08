# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which is enabled on virtually every Drupal
  site. To use it in the UI you will also want core's **Field UI** enabled (and,
  optionally, **Layout Builder**, which this formatter also supports).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_fallback_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_fallback_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_fallback_formatter -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage display**, pick a
field, and confirm that a **Fallback** formatter is available in the *Format*
column. Select it, configure a fallback field in its settings, and check that a
node with the main field empty renders the fallback field's value instead.
