# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Options** module (`options`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on this module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/checkbox_radio_buttons_multi_columns -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/checkbox_radio_buttons_multi_columns -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en checkbox_radio_buttons_multi_columns -y
```

## Verify it worked

Go to a content type (or any fieldable entity) that has a checkboxes or
radio-buttons list field, open its **Manage form display** tab, and confirm the
multi-column widget now appears as an option in that field's **Widget** dropdown.
Choosing it and setting a column count will lay the options out in a grid on the
add/edit form.
