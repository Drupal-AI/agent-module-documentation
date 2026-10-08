<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Select2** module (`drupal/select2`), which provides the autocomplete
  widget the connector uses. Composer installs it automatically with the command
  below.

> **Note:** the Select2 module also relies on the Select2 JavaScript library.
> Follow the Select2 module's own installation instructions to make sure its
> front-end library is available.

## Install with Composer

From the project root:

```bash
composer require drupal/api_data_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Select2 and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_data_connector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_data_connector -y
```

Enabling `api_data_connector` also enables Select2 if it is not already on.

## Next steps

Configure a field to use the API-backed Select2 autocomplete widget, pointing it
at your external API, as described in the [main guide](../index.md). Keep API
credentials in a secure store such as environment variables.
