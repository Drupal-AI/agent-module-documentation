# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Options** module (`options`) enabled — it is the module's only
  dependency and Drupal enables it automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/a11y_autocomplete_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/a11y_autocomplete_element -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en a11y_autocomplete_element -y
```

Once enabled, the accessible autocomplete widget becomes selectable on the
*Manage form display* screen of any entity with an Options field, and the
matching Form API element is available to custom form code. There is no
configuration. See [How to use it](../index.md#how-to-use-it) in the overview.
