# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ~9.5 || ^10 || ^11`).
- The **Webform** module (`drupal/webform`, `^5.15 || ^6.0`).
- Core's **Configuration Translation** module (`config_translation`).

Drupal enables the Configuration Translation dependency automatically. Webform is
pulled in by Composer if it isn't already present. For the Translate links to
actually do anything, your site also needs multilingual translation configured
(the core Language and Content/Configuration Translation setup).

## Install with Composer

From the project root:

```bash
composer require drupal/webform_translation_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_translation_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_translation_permissions -y
```

There are no submodules and no settings form. Once enabled, grant the two new
permissions at **People → Permissions** as described on the
[main page](../index.md).
