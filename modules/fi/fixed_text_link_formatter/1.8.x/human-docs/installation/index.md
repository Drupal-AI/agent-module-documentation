# Installation

## Requirements

Fixed Text Link Formatter needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Link** (`link`) module, enabled automatically as a dependency. (The
  file-field formatter also relies on core's File module, which is part of a
  standard install.)

There are no third-party libraries or contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/fixed_text_link_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fixed_text_link_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fixed_text_link_formatter -y
```

That's all. There is no configuration step — the two formatters (**Link with fixed
text** for link fields and **Link with a fixed text** for file fields) become
available immediately in the **Format** dropdown on any bundle's *Manage display*
page. See the [overview](../index.md) for how to set one on a field.
