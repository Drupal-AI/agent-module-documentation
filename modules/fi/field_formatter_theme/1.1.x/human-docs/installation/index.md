# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`). To configure the suggestions in the UI you
  will also want core's **Field UI** enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_formatter_theme -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_formatter_theme -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_formatter_theme -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage display**, click the
settings (gear) icon for a field, and confirm a text box for theme suggestion
terms appears. Enter a term, save, and confirm the new suggestion is available to
your theme (for example by adding a matching template file and seeing it take
effect).
