# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other Drupal module dependencies and no third‑party PHP library
requirements. To do anything visible you'll also need a tag manager (such as Google
Tag Manager) reading `window.dataLayer` on the front end, but that is set up
separately.

## Install with Composer

From the project root:

```bash
composer require drupal/cm_data_layer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cm_data_layer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cm_data_layer -y
```

## Verify it worked

There's nothing to configure. To confirm the module is doing its job, push a test
event from code (see "How to use it" in the [overview](../index.md)), load a page,
and inspect `window.dataLayer` in your browser's developer console — your event
should appear there.
