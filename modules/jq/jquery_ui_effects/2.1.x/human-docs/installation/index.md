# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The base **jQuery UI** module (`drupal/jquery_ui` `^1.7`). This is a required
  dependency — it supplies the vendored jQuery UI assets and the machinery that
  registers this module's effect libraries. Composer installs it for you
  automatically.

There are no other requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_effects -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the base `drupal/jquery_ui` module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_effects -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_effects -y
```

Enabling it also enables the base `jquery_ui` module if it is not already on. Both
modules need to be enabled for the effect libraries to be available.

## Verify it worked

There is no admin page to check. Confirm the module is enabled (for example
`drush pm:list --status=enabled | grep jquery_ui_effects`), then attach one of the
`jquery_ui_effects/*` libraries from your code (see the [overview](../index.md))
and confirm the effect runs on the page.
