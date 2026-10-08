# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Only core is required — the field relies on core's text/filter system for the
  per-row text formats. There are no contributed-module or third-party library
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/description_list_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/description_list_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en description_list_field -y
```

## Next step

There is no settings page. Add a **Description list** field to a content type as
described in the [overview](../index.md#how-to-use-it).

> **Note:** The module carries the **EUPL-1.2** license (it comes from the
> OpenEuropa project), rather than the GPL used by most Drupal contrib modules.
