# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other Drupal module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/plugin_form_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plugin_form_element -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plugin_form_element -y
```

## Submodules — optional

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Plugin form element test** | `plugin_form_element_test` | A test/example module that exercises the `plugin` and `plugins` elements. Useful as a working reference; not intended for production. |

Enable it only if you want the examples:

```bash
drush en plugin_form_element_test -y
```

## Verify it worked

This module provides form elements for developers, so there is no page to visit.
Once `drush pm:list` shows it as **Enabled**, the `plugin` and `plugins` element
types are available to use in your form arrays. Enabling the test submodule gives
you a working form to confirm the elements render.
