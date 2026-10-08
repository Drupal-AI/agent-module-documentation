# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Field** module (`field`), which is standard on almost every Drupal site.
  There are no other module dependencies.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_percentage_field -W
```

The Composer package name (`drupal/simple_percentage_field`) matches the module's
machine name (`simple_percentage_field`).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_percentage_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_percentage_field -y
```

Drupal enables core's Field module automatically as a dependency if it is not
already on.

## Verify it worked

Go to a content type's **Manage fields** screen and click **Add field**. If
**Simple percentage** appears in the list of available field types, the module is
installed correctly — see the [main guide](../index.md) for how to add the field,
set its min/max, and choose the formatter.
