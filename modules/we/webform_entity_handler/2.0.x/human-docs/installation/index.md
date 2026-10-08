# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Webform** module (`drupal/webform` `^5.6 || ^6.0`), which Drupal enables as
  a dependency. This module is an add-on to Webform.
- Optionally, the **Token** module (`drupal/token`) — suggested, not required. It
  adds a token browser UI that makes filling in token values easier.
- No extra Composer libraries or PHP-version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_entity_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and update
any shared dependencies as needed. To also add the optional token browser:

```bash
composer require drupal/token -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/webform_entity_handler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_entity_handler -y
```

There are no submodules and no settings form. Once enabled, the **Entity** handler
becomes available when you add a handler to any webform. See the
[overview](../index.md) for how to set it up.
