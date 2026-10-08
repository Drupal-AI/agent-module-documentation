# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No other modules are required, and there are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_entity_reference_selection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_entity_reference_selection -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_entity_reference_selection -y
```

## Verify it worked

Edit (or create) an entity reference field that targets a configuration entity type
— for example a field referencing **Image styles** or **Webforms**. On the field's
settings form, open the **Reference method** dropdown; you should see the selection
handler this module derives for that target type, along with settings for choosing
the allowed subset of items. See the [overview](../index.md) for how to configure
the field.
