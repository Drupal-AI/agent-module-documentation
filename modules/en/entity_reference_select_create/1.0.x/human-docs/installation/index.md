# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib or third‑party dependencies, and no PHP library requirements — the
  module needs nothing beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_select_create -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_select_create -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_select_create -y
```

## Verify it worked

Go to **Structure → Content types → *(any type with a reference field)* → Manage
form display**. Open the **Widget** dropdown for that field — you should now see
**Select list with create button** as an option. Selecting it, configuring its
settings, and saving confirms the module is working.
