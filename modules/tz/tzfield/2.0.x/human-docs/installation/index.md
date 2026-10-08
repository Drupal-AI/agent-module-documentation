# Installation

## Requirements

- **Drupal 11.1+ or 12** (`core_version_requirement: ^11.1 || ^12`). Earlier Drupal
  versions are not supported by the 2.0 line.
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tzfield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tzfield -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tzfield -y
```

## Verify it worked

Go to any bundle's **Manage fields** page (for example **Structure → Content types →
Article → Manage fields**) and click **Add field**. The **Time zone** field type
should appear in the list. Add it, then create or edit an entity of that type — you
should see a time-zone select on the form. See "How to use it" in the
[overview](../index.md) for the full field setup, including widgets and formatters.
